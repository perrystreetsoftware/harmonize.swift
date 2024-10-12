//
//  Array+ModifiersProviding.swift
//  Harmonize
//
//  Copyright (c) Perry Street Software 2024. All Rights Reserved.
//

import Foundation
import Semantics

/// An extension for arrays where the elements conform to both `Declaration` and `ModifiersProviding`,
/// providing filtering functionality based on modifiers.
public extension Array where Element: Declaration & ModifiersProviding {
    /// Filters the array to include only elements that have modifiers satisfying the given predicate.
    ///
    /// - parameter predicate: A closure that takes a `Modifier` and returns a Boolean value indicating
    ///   whether the modifier meets the specified criteria.
    /// - returns: An array of elements that contain modifiers satisfying the predicate.
    func withModifiers(_ predicate: (Modifier) -> Bool) -> [Element] {
        with(\.modifiers) { $0.contains(where: predicate) }
    }
    
    /// Filters the array to include only elements that do not have modifiers satisfying the given predicate.
    ///
    /// - parameter predicate: A closure that takes a `Modifier` and returns a Boolean value indicating
    ///   whether the modifier meets the specified criteria.
    /// - returns: An array of elements that do not contain modifiers satisfying the predicate.
    func withoutModifiers(_ predicate: (Modifier) -> Bool) -> [Element] {
        withNot(\.modifiers) { $0.contains(where: predicate) }
    }
    
    /// Filters the array to include only elements that have the specified modifiers.
    ///
    /// - parameter modifiers: A variadic list of `Modifier` values to check against the elements' modifiers.
    /// - returns: An array of elements that contain any of the specified modifiers.
    func withModifier(_ modifiers: Modifier...) -> [Element] {
        withModifiers { modifiers.contains($0) }
    }
    
    /// Filters the array to include only elements that do not have the specified modifiers.
    ///
    /// - parameter modifiers: A variadic list of `Modifier` values to check against the elements' modifiers.
    /// - returns: An array of elements that do not contain any of the specified modifiers.
    func withoutModifier(_ modifiers: Modifier...) -> [Element] {
        withoutModifiers { modifiers.contains($0) }
    }
    
    /// Filters the array to include only elements that have a public modifier.
    ///
    /// - returns: An array of elements that contain the `.public` modifier.
    func withPublicModifier() -> [Element] {
        withModifier(.public)
    }
    
    /// Filters the array to include only elements that have a private modifier.
    ///
    /// - returns: An array of elements that contain the `.private` modifier.
    func withPrivateModifier() -> [Element] {
        withModifier(.private)
    }
    
    /// Filters the array to include only elements that have a final modifier.
    ///
    /// - returns: An array of elements that contain the `.final` modifier.
    func withFinalModifier() -> [Element] {
        withModifier(.final)
    }
}
