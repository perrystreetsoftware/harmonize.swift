//
//  Modifier.swift
//  Harmonize
//
//  Copyright (c) Perry Street Software 2024. All Rights Reserved.
//

import Foundation
import SwiftSyntax

/// Represents a modifier in Swift syntax. This enum includes all possible modifiers
/// that can be applied to declarations such as functions, classes, and variables.
public enum Modifier: String, CaseIterable, Equatable {
    case borrowing = "borrowing"
    case consuming = "consuming"
    case convenience = "convenience"
    case distributed = "distributed"
    case dynamic = "dynamic"
    case `fileprivate` = "fileprivate"
    case final = "final"
    case indirect = "indirect"
    case infix = "infix"
    case `inout` = "inout"
    case `internal` = "internal"
    case isolated = "isolated"
    case lazy = "lazy"
    case mutating = "mutating"
    case nonmutating = "nonmutating"
    case open = "open"
    case optional = "optional"
    case override = "override"
    case package = "package"
    case postfix = "postfix"
    case prefix = "prefix"
    case `private` = "private"
    case `public` = "public"
    case required = "required"
    case `static` = "static"
    case privateSet = "private(set)"
    case unowned = "unowned"
    case weak = "weak"
    
    static func from(value: String) -> Modifier? {
        allCases.first { $0.rawValue == value }
    }
    
    static func modifiers(from node: DeclModifierListSyntax) -> [Self] {
        node.compactMap {
            let detail = $0.detail?.trimmedDescription ?? ""
            return Self.from(value: $0.name.text + detail)
        }
    }
}
