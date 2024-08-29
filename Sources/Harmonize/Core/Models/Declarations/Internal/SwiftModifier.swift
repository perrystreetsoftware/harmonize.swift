//
//  SwiftModifier.swift
//
//
//  Created by Lucas Cavalcante on 8/23/24.
//

import Foundation

public enum SwiftModifier: String, CaseIterable, Equatable {
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
    
    static func from(value: String) -> SwiftModifier? {
        allCases.first { $0.rawValue == value }
    }
}
