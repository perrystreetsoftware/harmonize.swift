//
//  Array+NamedDeclaration.swift
//  Harmonize
//
//  Copyright (c) Perry Street Software 2024. All Rights Reserved.
//

import Foundation
import Semantics

/// An extension for arrays where the elements conform to both `Declaration` and `NamedDeclaration`,
/// providing filtering functionality based on named declarations.
public extension Array where Element: Declaration & NamedDeclaration {
    /// Filters the array to include only elements whose names satifies the given predicate.
    ///
    /// - parameter predicate: name to match condition.
    /// - returns: An array containing the elements satisfying the given predicate.
    func withName(_ predicate: (String) -> Bool) -> [Element] {
        filter { predicate($0.name) }
    }
    
    /// Filters the array to include only elements whose names are in the given names.
    ///
    /// - parameter names: names to match condition.
    /// - returns: An array containing the elements satisfying the given predicate.
    func withName(_ names: [String]) -> [Element] {
        withName(names.contains)
    }
    
    /// Filters the array to include only elements whose names satifies the given name.
    ///
    /// - parameter name: name to match condition.
    /// - returns: An array containing the elements satisfying the given predicate.
    func withName(_ name: String) -> [Element] {
        withName([name])
    }
    
    /// Filters the array to exclude elements whose names satifies the given predicate.
    ///
    /// - parameter predicate: name to exclude.
    /// - returns: An array containing the elements satisfying the given predicate.
    func withoutName(_ predicate: (String) -> Bool) -> [Element] {
        filter { !predicate($0.name) }
    }
    
    /// Filters the array to exclude elements whose names are in the given names.
    ///
    /// - parameter names: names to exclude.
    /// - returns: An array containing the elements satisfying the given predicate.
    func withoutName(_ names: [String]) -> [Element] {
        withoutName(names.contains)
    }
    
    /// Filters the array to include only elements whose names end with any of the specified suffixes.
    ///
    /// - parameter suffixes: One or more suffixes to match.
    /// - returns: A filtered array of elements whose names end with one of the provided suffixes.
    func withSuffix(_ suffixes: String...) -> [Element] {
        withName {
            suffixes.contains(where: $0.hasSuffix)
        }
    }
    
    /// Filters the array to include only elements whose names do not end with any of the specified suffixes.
    ///
    /// - parameter suffixes: One or more suffixes to exclude.
    /// - returns: A filtered array of elements whose names do not end with any of the provided suffixes.
    func withoutSuffix(_ suffixes: String...) -> [Element] {
        withoutName {
            suffixes.contains(where: $0.hasSuffix)
        }
    }
    
    /// Filters the array to include only elements whose names start with any of the specified prefixes.
    ///
    /// - parameter prefixes: One or more prefixes to match.
    /// - returns: A filtered array of elements whose names start with one of the provided prefixes.
    func withPrefix(_ prefixes: String...) -> [Element] {
        withName {
            prefixes.contains(where: $0.hasPrefix)
        }
    }
    
    /// Filters the array to include only elements whose names do not start with any of the specified prefixes.
    ///
    /// - parameter prefixes: One or more prefixes to exclude.
    /// - returns: A filtered array of elements whose names do not start with any of the provided prefixes.
    func withoutPrefix(_ prefixes: String...) -> [Element] {
        withoutName {
            prefixes.contains(where: $0.hasPrefix)
        }
    }
    
    /// Filters the array to include only elements whose names contain any of the specified substrings.
    ///
    /// - parameter parts: One or more substrings to match.
    /// - returns: A filtered array of elements whose names contain one of the provided substrings.
    func withNameContaining(_ parts: String...) -> [Element] {
        withName {
            parts.contains(where: $0.contains)
        }
    }
    
    /// Filters the array to include only elements whose names do not contain any of the specified substrings.
    ///
    /// - parameter parts: One or more substrings to exclude.
    /// - returns: A filtered array of elements whose names do not contain any of the provided substrings.
    func withoutNameContaining(_ parts: String...) -> [Element] {
        withoutName {
            parts.contains(where: $0.contains)
        }
    }
}
