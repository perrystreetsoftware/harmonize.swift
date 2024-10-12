//
//  Array+ClassesProviding.swift
//  Harmonize
//
//  Copyright (c) Perry Street Software 2024. All Rights Reserved.
//

import Foundation
import Semantics

/// An extension for arrays where the elements conform to both `Declaration` and `ClassesProviding`,
/// providing filtering functionality based on body.
public extension Array where Element: Declaration & ClassesProviding {
    /// Filters the array to include only elements that have classes satisfying the given predicate.
    ///
    /// - parameter predicate: A closure that takes a `Class` and returns a Boolean value indicating
    ///   whether the class meets the specified criteria.
    /// - returns: An array of elements that contain at least one class satisfying the predicate.
    func withClasses(_ predicate: (Class) -> Bool) -> [Element] {
        with(\.classes) { $0.contains(where: predicate) }
    }
    
    /// Retrieves a flat array of all classes from the elements in the array.
    ///
    /// - returns: An array of `Class` instances extracted from each element in the array.
    func classes() -> [Class] {
        flatMap { $0.classes }
    }
}
