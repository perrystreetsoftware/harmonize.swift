//
//  Array+StructsProviding.swift
//  Harmonize
//
//  Copyright (c) Perry Street Software 2024. All Rights Reserved.
//

import Foundation
import HarmonizeSemantics

/// An extension for arrays where the elements conform to both `Declaration` and `StructsProviding`,
/// providing filtering functionality based on structs.
public extension Array where Element: Declaration & StructsProviding {
    /// Returns an array of elements that contain structs satisfying the specified predicate.
    ///
    /// - parameter predicate: A closure that takes a `Struct` and returns a Boolean value
    ///   indicating whether the struct should be included in the result.
    /// - returns: An array of elements that contain structs satisfying the predicate.
    func withStructs(_ predicate: (Struct) -> Bool) -> [Element] {
        with(\.structs) { $0.contains(where: predicate) }
    }
    
    /// Flattens the structs from all elements in the array into a single array.
    ///
    /// - returns: An array of all structs from the elements in the array.
    func structs() -> [Struct] {
        flatMap { $0.structs }
    }
}
