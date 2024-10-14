//
//  HarmonizeScope.swift
//  Harmonize
//
//  Copyright (c) Perry Street Software 2024. All Rights Reserved.
//

import Foundation
import HarmonizeSemantics

/// Represents a scope in which contains a bunch of files containing declarations to be harmonized.
public protocol HarmonizeScope {
    /// Returns a collection of `class` declarations.
    ///
    /// - parameter includeNested: Whether to include nested class declarations.
    func classes(includeNested: Bool) -> [Class]

    /// Returns top-level `class` declarations.
    func classes() -> [Class]

    /// Returns a collection of `enum` declarations.
    ///
    /// - parameter includeNested: Whether to include nested enum declarations.
    func enums(includeNested: Bool) -> [Enum]

    /// Returns top-level `enum` declarations.
    func enums() -> [Enum]

    /// Returns a collection of `extension` declarations.
    func extensions() -> [Extension]

    /// Returns the sources in this scope.
    ///
    /// A `SwiftSourceCode` can represent either a `.swift` file or plain source text,
    /// depending on whether the scope includes files or raw source code.
    func sources() -> [SwiftSourceCode]

    /// Returns a collection of `func` declarations.
    ///
    /// - parameter includeNested: Whether to include nested function declarations.
    func functions(includeNested: Bool) -> [Function]

    /// Returns top-level ``func`` declarations.
    func functions() -> [Function]

    /// Returns a collection of ``import`` declarations.
    func imports() -> [Import]

    /// Returns a collection of ``init`` declarations.
    func initializers() -> [Initializer]

    /// Returns a collection of ``var`` and ``let`` declarations.
    ///
    /// - parameter includeNested: Whether to include nested variable and constant declarations.
    func variables(includeNested: Bool) -> [Variable]

    /// Returns top-level ``var`` and ``let`` declarations.
    func variables() -> [Variable]

    /// Returns a collection of ``protocol`` declarations.
    ///
    /// - parameter includeNested: Whether to include nested protocol declarations.
    func protocols(includeNested: Bool) -> [ProtocolDeclaration]

    /// Returns top-level ``protocol`` declarations.
    func protocols() -> [ProtocolDeclaration]

    /// Returns a collection of ``struct`` declarations.
    ///
    /// - parameter includeNested: Whether to include nested struct declarations.
    func structs(includeNested: Bool) -> [Struct]

    /// Returns top-level ``struct`` declarations.
    func structs() -> [Struct]
}
