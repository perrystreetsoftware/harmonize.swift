//
//  Harmonize.swift
//  
//
//  Created by Lucas Cavalcante on 9/7/24.
//

import Foundation

/// The entry point for creating HarmonizeScope.
public struct Harmonize {
    private init() {}
    
    /// Static access for getting production and test code from the working directory. Allows `on` and `excludes` builders.
    /// - returns: access to `on`, `excludes` builders but also `HarmonizeScope`.
    public static func productionAndTestCode() -> On & Excluding {
        HarmonizeScopeBuilder()
    }
    
    /// Static access for getting production from the working directory. Allows `on` and `excludes` builders.
    /// - returns: access to `on`, `excludes` builders but also `HarmonizeScope`.
    public static func productionCode() -> On & Excluding {
        HarmonizeScopeBuilder(exclusions: ["Tests", "Fixtures"])
    }
    
    /// Static access for getting test code from the working directory. Allows `on` and `excludes` builders.
    /// - returns: access to `on`, `excludes` builders but also `HarmonizeScope`.
    public static func testCode() -> On & Excluding {
        HarmonizeScopeBuilder(includingOnly: ["Tests", "Fixtures"])
    }
}
