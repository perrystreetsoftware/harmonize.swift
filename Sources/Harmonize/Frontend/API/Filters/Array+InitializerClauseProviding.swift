//
//  Array+InitializerClauseProviding.swift
//  Harmonize
//
//  Copyright (c) Perry Street Software 2024. All Rights Reserved.
//

import Foundation
import HarmonizeSemantics

/// An extension for arrays where the elements conform to both `Declaration`
/// and `InitializerClauseProviding`,
/// providing filtering functionality based on initializer clause.
public extension Array where Element: Declaration & InitializerClauseProviding {
    /// Filters the array to include only elements that have an initializer clause satisfying the given predicate.
    ///
    /// - parameter predicate: A closure that takes an `InitializerClause` and returns a Boolean value indicating
    ///   whether the initializer clause meets the specified criteria.
    /// - returns: An array of elements that have an initializer clause satisfying the predicate.
    func withInitializerClause(_ predicate: (InitializerClause) -> Bool) -> [Element] {
        with(\.initializerClause) {
            guard let initializerClause = $0 else { return false }
            return predicate(initializerClause)
        }
    }
    
    /// Filters the array to include only elements that have an initializer clause with a value satisfying the given predicate.
    ///
    /// - parameter predicate: A closure that takes a `String` representing the value and returns a Boolean value indicating
    ///   whether the value meets the specified criteria.
    /// - returns: An array of elements that have an initializer clause with a value satisfying the predicate.
    func withValue(_ predicate: (String) -> Bool) -> [Element] {
        withInitializerClause {
            predicate($0.value)
        }
    }
    
    /// Filters the array to include only elements that have an initializer clause with a value matching the specified regex.
    ///
    /// - parameter regex: A regex component to check against the value of the initializer clause.
    /// - returns: An array of elements that have an initializer clause with a value containing the specified regex.
    func withValue(containing regex: any RegexComponent) -> [Element] {
        withValue { $0.contains(regex) }
    }
}
