//
//  Array+Declaration.swift
//  Harmonize
//
//  Copyright (c) Perry Street Software 2024. All Rights Reserved.
//

import Foundation
import Semantics

/// Provides extension methods for filtering arrays of declarations based on key paths.
public extension Array where Element: Declaration {
    /// Filters the array to include only elements where the specified key path's value satisfies the given predicate.
    ///
    /// - parameters:
    ///   - path: A key path to the property of the element to be evaluated.
    ///   - predicate: A closure that takes a value of the type at the key path and returns a Boolean value
    ///     indicating whether the value meets the specified criteria.
    /// - returns: An array of elements whose property at the specified key path satisfies the predicate.
    func with<KeyType>(
        _ path: KeyPath<Element, KeyType>,
        predicate: (KeyType) -> Bool
    ) -> [Element] {
        filter { predicate($0[keyPath: path]) }
    }
    
    /// Filters the array to include only elements where the specified key path's value does not satisfy the given predicate.
    ///
    /// - parameters:
    ///   - path: A key path to the property of the element to be evaluated.
    ///   - predicate: A closure that takes a value of the type at the key path and returns a Boolean value
    ///     indicating whether the value meets the specified criteria.
    /// - returns: An array of elements whose property at the specified key path does not satisfy the predicate.
    func withNot<KeyType>(
        _ path: KeyPath<Element, KeyType>,
        predicate: (KeyType) -> Bool
    ) -> [Element] {
        with(path, predicate: { !predicate($0) })
    }
}
