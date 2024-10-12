//
//  Array+VariablesProviding.swift
//  Harmonize
//
//  Copyright (c) Perry Street Software 2024. All Rights Reserved.
//

import Foundation
import Semantics

/// An extension for arrays where the elements conform to both `Declaration` and `VariablesProviding`,
/// providing filtering functionality based on variables.
public extension Array where Element: Declaration & VariablesProviding {
    /// Returns an array of elements that have variables satisfying the specified predicate.
    ///
    /// - parameter predicate: A closure that takes a `Variable` and returns a Boolean value
    ///   indicating whether the variable should be included in the result.
    /// - returns: An array of elements that have variables satisfying the predicate.
    func withVariables(_ predicate: (Variable) -> Bool) -> [Element] {
        with(\.variables) { $0.contains(where: predicate) }
    }
    
    /// Returns an array of all variables from the elements in the array.
    ///
    /// - returns: An array of all `Variable` instances contained within the elements.
    func variables() -> [Variable] {
        flatMap { $0.variables }
    }
}
