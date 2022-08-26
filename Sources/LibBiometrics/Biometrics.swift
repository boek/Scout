//
//  File.swift
//  
//
//  Created by Jeff Boek on 8/25/22.
//

import LocalAuthentication
import Foundation

public enum BiometricType {
    case none, touchID, faceID
}

public struct Biometrics {
    var isEnabled: () -> Bool
    var biometricType: BiometricType
    var authenticate: () async throws -> Bool
}


extension BiometricType {
    init(_ type: LABiometryType) {
        switch type {
        case .none: self = .none
        case .touchID: self = .touchID
        case .faceID: self = .faceID
        @unknown default: fatalError()
        }
    }
}
public extension Biometrics {
    static var live: Biometrics {
        let context = LAContext()
        return Biometrics(
            isEnabled: { context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: nil) },
            biometricType: .init(context.biometryType),
            authenticate: {
                try await context.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: context.localizedReason)
            }
        )
    }
}
