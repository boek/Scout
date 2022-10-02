//
//  File.swift
//  
//
//  Created by Jeff Boek on 8/21/22.
//

import ComposableArchitecture

public typealias WelcomeStore = Store<Void, WelcomeAction>

public enum WelcomeAction: Equatable {
    case startBrowsing
}
