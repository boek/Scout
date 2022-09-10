//
//  File.swift
//  
//
//  Created by Jeff Boek on 8/24/22.
//

import Foundation

extension CharacterSet {
    /// Returns the character set for characters allowed in a URL.
    static let urlAllowed = CharacterSet(charactersIn: "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789-._~:/?#[]@!$&'()*+,;=%")

    /// Returns the character set for characters allowed in a URL query parameter.
    static let urlQueryParameterAllowed = CharacterSet(charactersIn: "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789-._~")
}
