//
//  Array+BodyProviding.swift
//  Harmonize
//
//  Copyright (c) Perry Street Software 2024. All Rights Reserved.
//

import Foundation
import Semantics

/// An extension for arrays where the elements conform to both `Declaration` and `BodyProviding`,
/// providing filtering functionality based on body.
public extension Array where Element: Declaration & BodyProviding {
    /// Filters the array to include only elements with a body that satisfies the given predicate.
    ///
    /// - parameter predicate: A closure that takes a `String` representing the body of the element and returns
    ///   a Boolean value indicating whether the body meets the criteria.
    /// - returns: An array of elements whose body matches the specified predicate.
    func withBody(_ predicate: (String) -> Bool) -> [Element] {
        with(\.body) {
            guard let body = $0 else { return false }
            return predicate(body)
        }
    }
    
    /// Filters the array to include only elements with a body that contains the specified regex pattern.
    ///
    /// - parameter regex: A regex pattern to match against the body of the element.
    /// - returns: An array of elements whose body contains the specified regex pattern.
    func withBody(containing regex: some RegexComponent) -> [Element] {
        withBody { $0.contains(regex) }
    }
    
    /// Filters the array to include only elements without a body that satisfies the given predicate.
    ///
    /// - parameter predicate: A closure that takes a `String` representing the body of the element and returns
    ///   a Boolean value indicating whether the body meets the criteria.
    /// - returns: An array of elements whose body does not match the specified predicate.
    func withoutBody(_ predicate: (String) -> Bool) -> [Element] {
        withBody { !predicate($0) }
    }
}
