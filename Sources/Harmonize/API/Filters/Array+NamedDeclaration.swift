//
//  Array+NamedDeclaration.swift
//
//
//  Created by Lucas Cavalcante on 9/14/24.
//

import Foundation

public extension Array where Element: NamedDeclaration {
    func withName(_ predicate: (String) -> Bool) -> [Element] {
        filter { predicate($0.name) }
    }
    
    /// Filters the array to include only elements whose names end with any of the specified suffixes.
    ///
    /// - Parameter suffixes: One or more suffixes to match.
    /// - Returns: A filtered array of elements whose names end with one of the provided suffixes.
    func withSuffix(_ suffixes: String...) -> [Element] {
        withName {
            suffixes.contains(where: $0.hasSuffix)
        }
    }
    
    /// Filters the array to include only elements whose names do not end with any of the specified suffixes.
    ///
    /// - Parameter suffixes: One or more suffixes to exclude.
    /// - Returns: A filtered array of elements whose names do not end with any of the provided suffixes.
    func withoutSuffix(_ suffixes: String...) -> [Element] {
        withName {
            !suffixes.contains(where: $0.hasSuffix)
        }
    }
    
    /// Filters the array to include only elements whose names start with any of the specified prefixes.
    ///
    /// - Parameter prefixes: One or more prefixes to match.
    /// - Returns: A filtered array of elements whose names start with one of the provided prefixes.
    func withPrefix(_ prefixes: String...) -> [Element] {
        withName {
            prefixes.contains(where: $0.hasPrefix)
        }
    }
    
    /// Filters the array to include only elements whose names do not start with any of the specified prefixes.
    ///
    /// - Parameter prefixes: One or more prefixes to exclude.
    /// - Returns: A filtered array of elements whose names do not start with any of the provided prefixes.
    func withoutPrefix(_ prefixes: String...) -> [Element] {
        withName {
            !prefixes.contains(where: $0.hasPrefix)
        }
    }
    
    /// Filters the array to include only elements whose names contain any of the specified substrings.
    ///
    /// - Parameter parts: One or more substrings to match.
    /// - Returns: A filtered array of elements whose names contain one of the provided substrings.
    func withNameContaining(_ parts: String...) -> [Element] {
        withName {
            parts.contains(where: $0.contains)
        }
    }
    
    /// Filters the array to include only elements whose names do not contain any of the specified substrings.
    ///
    /// - Parameter parts: One or more substrings to exclude.
    /// - Returns: A filtered array of elements whose names do not contain any of the provided substrings.
    func withoutNameContaining(_ parts: String...) -> [Element] {
        withName {
            !parts.contains(where: $0.contains)
        }
    }
}
