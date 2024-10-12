//
//  Array+EnumsProviding.swift
//  Harmonize
//
//  Copyright (c) Perry Street Software 2024. All Rights Reserved.
//

import Foundation
import Semantics

/// An extension for arrays where the elements conform to both `Declaration` and `EnumsProviding`,
/// providing filtering functionality based on enums.
public extension Array where Element: Declaration & EnumsProviding {
    /// Filters the array to include only elements that contain enums satisfying the given predicate.
    ///
    /// - parameter predicate: A closure that takes an `Enum` and returns a Boolean value indicating
    ///   whether the enum meets the specified criteria.
    /// - returns: An array of elements that contain at least one enum satisfying the predicate.
    func withEnums(_ predicate: (Enum) -> Bool) -> [Element] {
        with(\.enums) { $0.contains(where: predicate) }
    }
    
    /// Retrieves a flat array of all enums from the elements in the array.
    ///
    /// - returns: An array of `Enum` instances extracted from each element in the array that
    ///   conforms to `EnumsProviding`.
    func enums() -> [Enum] {
        flatMap { $0.enums }
    }
}
