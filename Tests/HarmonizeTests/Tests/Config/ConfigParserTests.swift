//
//  ConfigParserTests.swift
//  Harmonize
//
//  Copyright (c) Perry Street Software 2024. All Rights Reserved.
//

import Foundation
import XCTest
@testable import Harmonize

final class ConfigParserTests: XCTestCase {
    func testParseConfig() throws {
        let source = """
        excludes:
          - Tests
        """
        
        XCTAssertEqual(
            try Config(source),
            Config(excludePaths: ["Tests"])
        )
    }
    
    func testParseConfigIfSourceIsEmpty() throws {
        let source = """
        """
        
        XCTAssertEqual(
            try Config(source),
            Config(excludePaths: [])
        )
    }
}
