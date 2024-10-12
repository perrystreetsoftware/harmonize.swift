//
//  Array+InitializersProviding.swift
//  Harmonize
//
//  Copyright (c) Perry Street Software 2024. All Rights Reserved.
//

import Foundation
import Semantics

/// An extension for arrays where the elements conform to both `Declaration` and `InitializersProviding`,
/// providing filtering functionality based on initializers.
public extension Array where Element: Declaration & InitializersProviding {
    /// Filters the array to include only elements that have initializers satisfying the given predicate.
    ///
    /// - parameter predicate: A closure that takes an `Initializer` and returns a Boolean value indicating
    ///   whether the initializer meets the specified criteria.
    /// - returns: An array of elements that contain initializers satisfying the predicate.
    func withInitializers(_ predicate: (Initializer) -> Bool) -> [Element] {
        with(\.initializers) { $0.contains(where: predicate) }
    }
    
    /// Retrieves an array of all initializers from the elements in the array.
    ///
    /// - returns: An array containing all `Initializer` instances from the elements that conform to
    ///   the `InitializersProviding` protocol.
    func initializers() -> [Initializer] {
        flatMap { $0.initializers }
    }
}
