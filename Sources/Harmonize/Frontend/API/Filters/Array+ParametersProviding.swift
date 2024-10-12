//
//  Array+ParametersProviding.swift
//  Harmonize
//
//  Copyright (c) Perry Street Software 2024. All Rights Reserved.
//

import Foundation
import Semantics

/// An extension for arrays where the elements conform to both `Declaration` and `ParametersProviding`,
/// providing filtering functionality based on parameters.
public extension Array where Element: Declaration & ParametersProviding {
    /// Returns an array of elements that have parameters satisfying the specified predicate.
    ///
    /// - parameter predicate: A closure that takes a `Parameter` and returns a Boolean value
    ///   indicating whether the parameter should be included in the result.
    /// - returns: An array of elements that have parameters satisfying the predicate.
    func withParameters(_ predicate: (Parameter) -> Bool) -> [Element] {
        with(\.parameters) { $0.contains(where: predicate) }
    }
    
    /// Flattens the parameters from all elements in the array into a single array.
    ///
    /// - returns: An array of all parameters from the elements in the array.
    func parameters() -> [Parameter] {
        flatMap { $0.parameters }
    }
}
