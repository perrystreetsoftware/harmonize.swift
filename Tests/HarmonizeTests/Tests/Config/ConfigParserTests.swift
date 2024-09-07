//
//  ConfigParserTests.swift
//  
//
//  Created by Lucas Cavalcante on 9/7/24.
//

import Foundation
import XCTest
import Harmonize

final class ConfigParserTests: XCTestCase {
    func testAssertCanParseConfig() throws {
        let source = """
        includes:
          - Folder
          - SomeOtherFolder
        excludes:
          - Tests
        """
        
        XCTAssertEqual(
            try Config(source),
            Config(includePaths: ["Folder", "SomeOtherFolder"], excludePaths: ["Tests"])
        )
    }
    
    func testAssertCanParseConfigIfSourceIsEmpty() throws {
        let source = """
        """
        
        XCTAssertEqual(
            try Config(source),
            Config(includePaths: [], excludePaths: [])
        )
    }
    
    func testAssertCanParseConfigEmptyPaths() throws {
        let source = """
        includes:
          - Folder
          - SomeOtherFolder
        """
        
        XCTAssertEqual(
            try Config(source),
            Config(includePaths: ["Folder", "SomeOtherFolder"], excludePaths: [])
        )
    }
}
