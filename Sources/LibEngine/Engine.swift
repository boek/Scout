import Combine
import WebKit

public struct EngineViewFactory: Equatable {
    public var id: String
    public var factory: () -> UIView

    public init(
        id: String = UUID().uuidString,
        factory: @escaping () -> UIView
    ) {
        self.id = id
        self.factory = factory
    }

    func callAsFunction() -> UIView {
        return factory()
    }

    public static func == (lhs: EngineViewFactory, rhs: EngineViewFactory) -> Bool {
        lhs.id == rhs.id
    }
}

public enum EngineScrollState {
    case inert
    case scrolling(start: CGPoint, current: CGPoint)
}

public struct NavigationState {
    var canGoBack: Bool
    var canGoForward: Bool
}

public enum EngineAction {
    case load(URLRequest)
    case goBack
    case goForward
}

public enum EngineEvent {
    case updateEstimatedProgress(Double)
    case didStartProvisionalNavigation
    case didStartNavigation
    case didFinishNavigation
    case didNavigateBack
    case didNavigateForward
    case didReload
    case urlDidChange
    case pullToRefresh
}

public struct Engine {
    public var viewFactory: EngineViewFactory
    public var dispatch: (EngineAction) -> Void
    public var events: AnyPublisher<EngineEvent, Never>
}

public extension Engine {
    static var test: Self {
        .init(
            viewFactory: EngineViewFactory(id: "test-factory") { UIView() },
            dispatch: { _ in },
            events: Empty().eraseToAnyPublisher()
        )
    }

    static var system: Self {
        let webviewController = SystemWebViewController()

        return Engine(
            viewFactory: EngineViewFactory {
                webviewController.webView
            },
            dispatch: { action in
                switch action {
                case .load(let urlRequest): webviewController.load(urlRequest)
                case .goBack: webviewController.goBack()
                case .goForward: webviewController.goForward()
                }
            },
            events: webviewController.events
        )
    }
}

class FullScreenWKWebView: WKWebView {
    override var safeAreaInsets: UIEdgeInsets { .zero }
}

class SystemWebViewController: NSObject {
    private let _events = PassthroughSubject<EngineEvent, Never>()
    var events: AnyPublisher<EngineEvent, Never> { _events.eraseToAnyPublisher() }
    private var subscriptions = Set<AnyCancellable>()

    lazy var webView: WKWebView = {
        let configuration = WKWebViewConfiguration()
        configuration.allowsInlineMediaPlayback = true
        configuration.websiteDataStore = .nonPersistent()

        let view = WKWebView(frame: .zero, configuration: configuration)
        view.scrollView.delegate = self
        view.navigationDelegate = self
        view.allowsBackForwardNavigationGestures = true
        view.scrollView.contentInsetAdjustmentBehavior = .automatic
        view.allowsLinkPreview = true
        view.scrollView.clipsToBounds = false

        view.publisher(for: \.estimatedProgress)
            .sink { [weak self] in self?._events.send(.updateEstimatedProgress($0)) }
            .store(in: &subscriptions)

        return view
    }()

    func goBack() {
        webView.goBack()
    }

    func goForward() {
        webView.goForward()
    }

    func load(_ request: URLRequest) {
        webView.load(request)
    }
}

extension SystemWebViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        _events.send(.didFinishNavigation)
    }
}

extension SystemWebViewController: WKUIDelegate {

}

extension SystemWebViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        print(scrollView.contentOffset)
    }

    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {

    }

    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {

    }

    func scrollViewShouldScrollToTop(_ scrollView: UIScrollView) -> Bool {
        return true
    }
}
