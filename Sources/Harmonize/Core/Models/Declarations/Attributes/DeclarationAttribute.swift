//
//  DeclarationAttribute.swift
//
//
//  Created by Lucas Cavalcante on 8/24/24.
//

import Foundation

public enum DeclarationAttribute: String, CaseIterable, Equatable {
    case attached = "@attached"
    case available = "@available"
    case backDeployed = "@backDeployed"
    case discardableResult = "@discardableResult"
    case dynamicCallable = "@dynamicCallable"
    case dynamicMemberLookup = "@dynamicMemberLookup"
    case freestanding = "@freestanding"
    case frozen = "@frozen"
    case gkInspectable = "@GKInspectable"
    case inlinable = "@inlinable"
    case main = "@main"
    case nonobjc = "@nonobjc"
    case nsApplicationMain = "@NSApplicationMain"
    case nsCopying = "@NSCopying"
    case nsManaged = "@NSManaged"
    case objc = "@objc"
    case objcMembers = "@objcMembers"
    case preconcurrency = "@preconcurrency"
    case propertyWrapper = "@propertyWrapper"
    case resultBuilder = "@resultBuilder"
    case requiresStoredPropertyInits = "@requires_stored_property_inits"
    case testable = "@testable"
    case uiApplicationMain = "@UIApplicationMain"
    case unchecked = "@unchecked"
    case usableFromInline = "@usableFromInline"
    case warnUnqualifiedAccess = "@warn_unqualified_access"
    
    public static func from(name: String) -> DeclarationAttribute? {
        allCases.first { $0.rawValue == name }
    }
}

