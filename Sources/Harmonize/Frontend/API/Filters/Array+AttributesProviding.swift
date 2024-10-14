//
//  Array+AttributesProviding.swift
//  Harmonize
//
//  Copyright (c) Perry Street Software 2024. All Rights Reserved.
//

import Foundation
import HarmonizeSemantics

/// An extension for arrays where the elements conform to both `Declaration` and `AttributesProviding`,
/// providing filtering functionality based on attributes.
public extension Array where Element: Declaration & AttributesProviding {
    /// Filters the array to include only elements that have at least one attribute
    /// matching the given predicate.
    ///
    /// - parameter predicate: A closure that takes an `Attribute` and returns `true`
    ///   if the attribute satisfies the condition.
    /// - returns: An array of elements where at least one attribute matches the predicate.
    func withAttribute(_ predicate: (Attribute) -> Bool) -> [Element] {
        with(\.attributes) { $0.contains(where: predicate) }
    }
    
    /// Filters the array to include only elements that have an attribute with a
    /// specified name.
    ///
    /// - parameter named: The name of the attribute to filter by, with or without
    ///   the `@` symbol.
    /// - returns: An array of elements that contain an attribute matching the provided name.
    func withAttribute(named: String) -> [Element] {
        let name = named.replacingOccurrences(of: "@", with: "")
        return withAttribute { $0.name == name }
    }
    
    /// Filters the array to include only elements that have an attribute with a
    /// specific annotation.
    ///
    /// - parameter annotation: The `Annotation` associated with the attribute to filter by.
    /// - returns: An array of elements that contain an attribute matching the provided annotation.
    func withAttribute(annotatedWith annotation: Attribute.Annotation) -> [Element] {
        withAttribute { $0.annotation == annotation }
    }
    
    /// Filters the array to include only elements whose attributes contains a given property wrapper.
    ///
    /// In cases where the property wrapper has a generic constraint, this function will ignore it.
    /// e.g: `Published<Int>.self` will fallback to `@Published`
    ///
    /// - parameter type: the property wrapper type the elements should be attributed with.
    /// - returns: elements attributed with the given property wrapper.
    func withAttribute<T>(_ type: T.Type) -> [Element] {
        let regexMatchingTypeValue = #/<[^>]+>/#
        let typeName = String(describing: type).replacing(regexMatchingTypeValue, with: "")
        return withAttribute { $0.name == typeName }
    }
}
