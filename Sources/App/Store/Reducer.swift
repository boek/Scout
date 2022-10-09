//
//  File.swift
//  
//
//  Created by Jeff Boek on 10/1/22.
//

import Foundation
import ComposableArchitecture

import FeatureBrowser
import FeatureLock
import FeatureSearch
import FeatureSettings
import FeatureToolbar
import FeatureWelcome

public typealias AppReducer = Reducer<AppState, AppAction, AppEnvironment>

public let appReducerCore = AppReducer { state, action, environment in
    switch action {
    case .binding: return .none
    case .lifecycle(.initialize):
        state.search.searchSuggestionState = environment.defaults.searchSuggestionState
        state.lock.isEnabled = environment.biometrics.isEnabled() ? environment.defaults.shouldLock : false
        state.shouldShowOnboarding = !environment.defaults.userHasSeenOnboarding
        environment.crash.initialize("Key")
        environment.experiments.initialize()
        environment.defaults.increaseLaunchCount(by: 1)

        return .run { send in
            try await environment.contentBlocker.reload()
            let searchEngines = try await environment.searchEngines.load()
            await send(.searchEnginesLoaded(searchEngines))
        } catch: { _, _ in

        }
    case .lifecycle(.active): return .none
    case .lifecycle(.inactive):
        return .run { send in
            await send (.lock(.attemptLock))
        }
    case .lifecycle: return .none
    case .browser(.engine(.themeColorChanged(let color))):
        state.toolbar.backgroundColor = color
        return .none
    case .browser(.engine(.updateEstimatedProgress(let progress))):
        state.toolbar.progress = progress
        return .none
    case .browser(.engine(.didFinishNavigation)):
        state.toolbar.progress = nil
        return .none
    case .browser: return .none
    case .lock: return .none
    case .toolbar(.onSubmit):
        var url = state.toolbar.query.asURL //?? state.searchEngine?.queryUrl(query)
        if let url = url {
            let request = URLRequest(url: url)
            environment.engine.dispatch(.load(request))
        }
        state.showBrowser = true
    return .none
    case .toolbar(.binding(\.$query)):
        let query = state.toolbar.query
        return .task { .search(.perform(query)) }
    case .toolbar(.settingsTapped):
        state.showSettings = true
        return .none
    case .toolbar(.trashTapped):
        guard environment.defaults.launchThreshold != 0 else {
            environment.defaults.setLaunchThreshold(15)
            return .none
        }

        guard environment.defaults.launchCount <= environment.defaults.launchThreshold else {
            return .none
        }

        let daysSinceLastRequest = environment.defaults.lastReviewDate
            .flatMap { lastReviewDate in
                let now = environment.date()
                return Calendar.current.dateComponents([.day], from: lastReviewDate, to: now).day
            }

        if let daysSinceLastRequest = daysSinceLastRequest,
           daysSinceLastRequest < 90
        {
            return .none
        }

        environment.defaults.setLastReviewDate(environment.date())

        switch environment.defaults.launchThreshold {
        case 14: environment.defaults.setLaunchThreshold(64)
        case 64: environment.defaults.setLaunchThreshold(115)
        default: break
        }

        environment.appStore.requestReview()

        return .none
    case .toolbar: return .none
    case .settings(.binding):
        state.search.anchorToBottom = state.toolbar.toolbarPosition == .bottom
        return .none
    case .search(.allowSearchSuggestions), .search(.denySearchSuggestions):
        environment.defaults.searchSuggestionState(state.search.searchSuggestionState)
        return .none
    case .search(let action):
        return .none
    case .settings: return .none
    case .welcome(.startBrowsing):
        environment.defaults.userHasSeenOnboarding(true)
        state.shouldShowOnboarding = false
        return .none
    case .searchEnginesLoaded(let engines):
        state.search.searchEngines = engines
        state.search.selectedSearchEngine = engines.first
        return .none
    }
}
    .binding()
    .telemetry()
    .debugActions(actionFormat: .labelsOnly, environment: \.debug)

public let appReducer = AppReducer.combine(
    browserReducer.pullback(
        state: \.browser,
        action: /AppAction.browser,
        environment: \.browser
    ),
    lockReducer.pullback(
        state: \.lock,
        action: /AppAction.lock,
        environment: \.lock
    ),
    searchReducer.pullback(
        state: \.search,
        action: /AppAction.search,
        environment: \.search),
    settingsReducer.pullback(
        state: \.settings,
        action: /AppAction.settings,
        environment: \.settings),
    toolbarReducer.pullback(
        state: \.toolbar,
        action: /AppAction.toolbar,
        environment: \.toolbar),
    appReducerCore
)
