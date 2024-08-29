//
//  SwiftTypeAttribute.swift
//
//
//  Created by Lucas Cavalcante on 8/24/24.
//

import Foundation

public enum SwiftTypeAttribute: String, CaseIterable, Equatable {
    case autoclosure = "@autoclosure"
    case conventionC = "@convention(c)"
    case conventionBlock = "@convention(block)"
    case conventionSwift = "@convention(swift)"
    case escaping = "@escaping"
    case sendable = "@Sendable"
    
    public static func from(name: String) -> SwiftTypeAttribute? {
        allCases.first { $0.rawValue == name }
    }
}

