//
//  Array+InheritanceProviding.swift
//  Harmonize
//
//  Copyright (c) Perry Street Software 2024. All Rights Reserved.
//

import Foundation
import Semantics

/// An extension for arrays where the elements conform to both `Declaration` and `InheritanceProviding`,
/// providing filtering functionality based on inheritance clause.
public extension Array where Element: Declaration & InheritanceProviding {
    /// Filters the array to include only elements that inherit from the specified class type.
    ///
    /// - Parameter anyClass: The class type to check inheritance against.
    /// - Returns: An array of elements that inherit from the specified class.
    func inheriting(_ anyClass: AnyObject.Type) -> [Element] {
        filter { $0.inherits(from: anyClass) }
    }
    
    /// Filters the array to include only elements that inherit from the specified class name.
    ///
    /// - Parameter name: The name of the class to check inheritance against.
    /// - Returns: An array of elements that inherit from the specified class name.
    func inheriting(from name: String) -> [Element] {
        filter { $0.inherits(from: name) }
    }
    
    /// Filters the array to include only elements that conform to the specified protocol type.
    ///
    /// - Parameter proto: The protocol type to check conformance against.
    /// - Returns: An array of elements that conform to the specified protocol.
    func conforming<T>(to proto: T.Type) -> [Element] {
        filter { $0.conforms(to: proto) }
    }
    
    /// Filters the array to include only elements that conform to the specified protocol names.
    ///
    /// - Parameter names: The protocol names to check conformance against.
    /// - Returns: An array of elements that conform to the specified protocol names.
    func conforming(to names: String...) -> [Element] {
        filter { $0.conforms(to: names) }
    }
    
    /// Filters the array to include only elements that conform to the specified protocol names.
    ///
    /// - Parameter names: An array of protocol names to check conformance against.
    /// - Returns: An array of elements that conform to the specified protocol names.
    func conforming(to names: [String]) -> [Element] {
        filter { $0.conforms(to: names) }
    }
}
