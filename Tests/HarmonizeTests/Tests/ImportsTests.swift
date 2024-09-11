//
//  ImportsTests.swift
//
//
//  Created by Lucas Cavalcante on 9/5/24.
//

import Foundation
import Harmonize
import XCTest

final class ImportsTests: XCTestCase {
    private var harmonize = TestUtils.harmonize(at: "Fixtures/Imports")
    
    func testAssertCanParseImports() throws {
        let imports = harmonize.imports()
        let names = imports.map { $0.name }
        
        XCTAssertEqual(imports.count, 6)
        XCTAssertEqual(
            names,
            [
                "Foundation.FoundationErrors",
                "Foundation.AffineTransform",
                "Foundation.FoundationErrors.NSFileNoSuchFileError",
                "Combine.Subscriber",
                "Combine",
                "Harmonize"
            ]
        )
    }
    
    func testAssertCanParseDeclarationImports() throws {
        let imports = harmonize.imports()
        let kinds = imports.map { $0.kind }
        
        XCTAssertEqual(kinds, [.none, .struct, .var, .protocol, .none, .none])
    }
    
    func testAssertCanParseAttributes() throws {
        let imports = harmonize.imports()
        let attributes = imports.flatMap { $0.attributes }.map { $0.annotation }
        
        XCTAssertEqual(attributes, [.testable])
    }
}
