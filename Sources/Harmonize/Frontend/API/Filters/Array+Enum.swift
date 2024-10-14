//
//  Array+Enum.swift
//  Harmonize
//
//  Copyright (c) Perry Street Software 2024. All Rights Reserved.
//

import Foundation
import HarmonizeSemantics

/// Provides extension methods for filtering and retrieving cases from an array of enums.
public extension Array where Element == Enum {
    /// Filters the array to include only enum elements that contain cases satisfying the given predicate.
    ///
    /// - parameter predicate: A closure that takes an `EnumCase` and returns a Boolean value indicating
    ///   whether the case meets the specified criteria.
    /// - returns: An array of enum elements that contain at least one case satisfying the predicate.
    func withCases(_ predicate: (EnumCase) -> Bool) -> [Element] {
        with(\.cases) { $0.contains(where: predicate) }
    }
    
    /// Retrieves a flat array of all cases from the enum elements in the array.
    ///
    /// - returns: An array of `EnumCase` instances extracted from each enum element in the array.
    func cases() -> [EnumCase] {
        flatMap { $0.cases }
    }
}
