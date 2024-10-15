//
//  Harmonize.swift
//  Harmonize
//
//  Copyright (c) Perry Street Software 2024. All Rights Reserved.
//

import Foundation

/// The entry point for creating HarmonizeScope.
public struct Harmonize {
    private init() {}
    
    /// Resolves the production and test code from the working directory.
    ///
    /// - returns: access to ``on``, ``excludes`` builders and ``HarmonizeScope``.
    public static func productionAndTestCode(_ file: StaticString = #file) -> On & Excluding {
        HarmonizeScopeBuilder(file: file)
    }
    
    /// Resolves the production code from the working directory by ignoring `Tests` and `Fixtures`.
    ///
    /// - returns: access to ``on``, ``excludes`` builders and ``HarmonizeScope``.
    public static func productionCode(_ file: StaticString = #file) -> On & Excluding {
        HarmonizeScopeBuilder(file: file, exclusions: ["Tests", "Fixtures"])
    }
    
    /// Resolves the test code from the working directory by including only `Tests` and `Fixtures` targets.
    ///
    /// - returns: access to ``on``, ``excludes`` builders and ``HarmonizeScope``.
    public static func testCode(_ file: StaticString = #file) -> On & Excluding {
        HarmonizeScopeBuilder(file: file, includingOnly: ["Tests", "Fixtures"])
    }
    
    /// A convenience method for ``Harmonize.productionCode().on(folder)``.
    ///
    /// This method simplifies specifying a folder path within the production code scope.
    ///
    /// - returns: ``Excluding`` scope builder.
    public static func on(_ folder: String, _ file: StaticString = #file) -> Excluding {
        productionCode(file).on(folder)
    }
    
    /// A convenience method for ``Harmonize.productionCode().excluding(folder)``.
    ///
    /// This method simplifies excluding a folder path from the production code scope.
    ///
    /// - returns: ``HarmonizeScope``.
    public static func excluding(_ folder: String, _ file: StaticString = #file) -> HarmonizeScope {
        productionCode(file).excluding(folder)
    }
    
    /// Creates a `HarmonizeScope` using the provided Swift source as string.
    ///
    /// - Parameter source: A closure that returns the source code as a `String`.
    /// - Returns: ``HarmonizeScope`` built from the provided source.
    public static func on(source: () -> String) -> HarmonizeScope {
        on(source: source())
    }

    /// Creates a `HarmonizeScope` using the provided Swift source as string.
    ///
    /// - parameter source: The source code as a `String`.
    /// - returns: ``HarmonizeScope`` built from the provided source.
    public static func on(source: String) -> HarmonizeScope {
        PlainSourceScopeBuilder(source: source)
    }
}
