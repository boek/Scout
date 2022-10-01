//
//  SwiftUIView.swift
//  
//
//  Created by Jeff Boek on 8/21/22.
//

import ComposableArchitecture
import SwiftUI
import LibUI

struct CenterAlignedLabelStyle: LabelStyle {
    func makeBody(configuration: Configuration) -> some View {
        Label {
            configuration.title
                .alignmentGuide(.leading) {
                    $0[.leading]
                }
        } icon: {
            configuration.icon
                .alignmentGuide(.firstTextBaseline) {
                    $0[VerticalAlignment.center]
                }
        }
    }
}

struct Instruction {
    var image: Image
    var title: String
    var subtitle: String
}

struct InstructionView: View {
    let instruction: Instruction

    var body: some View {
        Label {
            VStack(alignment: .leading) {
                Text(instruction.title)
                    .font(.headline)
                    .padding(.bottom, 6)
                Text(instruction.subtitle)
                    .font(.subheadline)
            }
        } icon: {
            instruction.image
                .frame(width: 28)
                .padding(.trailing, 20)
        }
    }
}

public struct WelcomeView: View {
    public let store: WelcomeStore

    public init(store: WelcomeStore) {
        self.store = store
    }

    public var body: some View {
        WithViewStore(store) { viewStore in
            VStack {
                ScrollView {
                    VStack(spacing: 24) {
                        Text("Welcome to Scout!").font(.headline)
                        Text("Take your browsing to the next level.").font(.subheadline)

                        VStack(alignment: .leading, spacing: 24) {
                            InstructionView(
                                instruction: .init(
                                    image: Image(systemName: "theatermasks"),
                                    title: "More than just incognito",
                                    subtitle: "Scout is a dedicated privacy browser with tracking protection and content blocking"
                                )
                            )

                            InstructionView(
                                instruction: .init(
                                    image: Image(systemName: "clock"),
                                    title: "Your histroy doesn't follow you",
                                    subtitle: "Erase your browsing history, passwords, cookies, and prevent unwanted ads from following you in a simple click!"
                                )
                            )

                            InstructionView(
                                instruction: .init(
                                    image: Image(systemName: "gearshape"),
                                    title: "Protection at your own discretion",
                                    subtitle: "Configure settings so you can decide how much or how little you share."
                                )
                            )
                        }
                    }
                }
                
                Button(action: { viewStore.send(.startBrowsing) }) {
                    HStack {
                        Spacer()
                        Text("Start browsing")
                        Spacer()
                    }
                }
                .buttonStyle(.primary)
                .frame(minWidth: 0, maxWidth: .infinity)
            }
            .padding()
        }
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView(store: .init(initialState: (), reducer: .empty, environment: ()))
    }
}
