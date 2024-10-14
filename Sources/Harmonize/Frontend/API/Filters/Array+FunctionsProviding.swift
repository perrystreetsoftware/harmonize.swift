//
//  Array+FunctionsProviding.swift
//  Harmonize
//
//  Copyright (c) Perry Street Software 2024. All Rights Reserved.
//

import Foundation
import HarmonizeSemantics

/// An extension for arrays where the elements conform to both `Declaration` and `FunctionsProviding`,
/// providing filtering functionality based on functions.
public extension Array where Element: Declaration & FunctionsProviding {
    /// Filters the array to include only elements that contain functions satisfying the given predicate.
    ///
    /// - Parameter predicate: A closure that takes a `Function` and returns a Boolean value indicating
    ///   whether the function meets the specified criteria.
    /// - Returns: An array of elements that contain at least one function satisfying the predicate.
    func withFunctions(_ predicate: (Function) -> Bool) -> [Element] {
        with(\.functions) { $0.contains(where: predicate) }
    }
    
    /// Retrieves a flat array of all functions from the elements in the array.
    ///
    /// - Returns: An array of `Function` instances extracted from each element in the array that
    ///   conforms to `FunctionsProviding`.
    func functions() -> [Function] {
        flatMap { $0.functions }
    }
}
