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
    public var isEnabled: () -> Bool
    public var biometricType: BiometricType
    public var authenticate: () async throws -> Bool

    public init(
        isEnabled: @escaping () -> Bool,
        biometricType: BiometricType,
        authenticate: @escaping () async throws -> Bool
    ) {
        self.isEnabled = isEnabled
        self.biometricType = biometricType
        self.authenticate = authenticate
    }
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
    static func live(context: LAContext = LAContext()) -> Biometrics {
        return Biometrics(
            isEnabled: {
                var error: NSError?
                let result = context.canEvaluatePolicy(.deviceOwnerAuthentication, error: &error)
                guard let error = error else { return result }
                print("Biometrics received error", error)
                return false
            },
            biometricType: .init(context.biometryType),
            authenticate: {
                context.localizedReason = "We need this"
                return try await context.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: "We need this")
            }
        )
    }

    static var test: Biometrics {
        return Biometrics(
            isEnabled: { true },
            biometricType: .touchID,
            authenticate: { true }
        )
    }
}
