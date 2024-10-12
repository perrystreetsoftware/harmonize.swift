//
//  Array+ProtocolsProviding.swift
//  Harmonize
//
//  Copyright (c) Perry Street Software 2024. All Rights Reserved.
//

import Foundation
import Semantics

/// An extension for arrays where the elements conform to both `Declaration` and `ProtocolsProviding`,
/// providing filtering functionality based on protocols.
public extension Array where Element: Declaration & ProtocolsProviding {
    /// Returns an array of elements that conform to protocols satisfying the specified predicate.
    ///
    /// - parameter predicate: A closure that takes a `ProtocolDeclaration` and returns a Boolean value
    ///   indicating whether the protocol should be included in the result.
    /// - returns: An array of elements that conform to protocols satisfying the predicate.
    func withProtocols(_ predicate: (ProtocolDeclaration) -> Bool) -> [Element] {
        with(\.protocols) { $0.contains(where: predicate) }
    }
    
    /// Flattens the protocols from all elements in the array into a single array.
    ///
    /// - returns: An array of all protocols from the elements in the array.
    func protocols() -> [ProtocolDeclaration] {
        flatMap { $0.protocols }
    }
}
