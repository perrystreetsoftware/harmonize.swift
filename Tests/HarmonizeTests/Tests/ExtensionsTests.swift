//
//  ExtensionsTests.swift
//  
//
//  Created by Lucas Cavalcante on 9/5/24.
//

import Foundation
import Harmonize
import XCTest

final class ExtensionsTests: XCTestCase {
    private var harmonize = TestUtils.harmonize(at: "Fixtures/Extensions")

    func testAssertCanParseExtensions() throws {
        let extensions = harmonize.extensions()
        XCTAssertEqual(extensions.count, 2)
    }
    
    func testAssertCanParseExtensionsTypeNames() throws {
        let extensions = harmonize.extensions()
        let names = extensions.map { $0.extendedTypeName }
        
        XCTAssertEqual(names, ["Properties", "Role"])
    }

    func testAssertCanParseExtensionsModifiers() throws {
        let modifiers = harmonize.extensions().flatMap { $0.modifiers }
        XCTAssertEqual(modifiers, [.fileprivate])
    }
    
    func testAssertCanParseExtensionsFunctions() throws {
        let extensions = harmonize.extensions()
        let functions = extensions.flatMap { $0.functions }
        
        XCTAssertEqual(functions.count, 1)
        XCTAssertEqual(functions.first?.name, "mergeThemAll")
    }
    
    func testAssertCanParseExtensionsProperties() throws {
        let extensions = harmonize.extensions()
        let properties = extensions.flatMap { $0.properties }
        
        XCTAssertEqual(properties.count, 1)
        XCTAssertEqual(properties.first?.name, "allCases")
    }
    
    func testAssertCanParseExtensionsInitializers() throws {
        let extensions = harmonize.extensions()
        let initializers = extensions.flatMap { $0.initializers }
        
        XCTAssertEqual(initializers.count, 1)
        XCTAssertEqual(initializers.first?.modifiers, [.convenience])
    }
    
    func testAssertCanParseExtensionsTypesConformance() throws {
        let extensions = harmonize.extensions()
        let conformance = extensions.flatMap { $0.inheritanceTypesNames }
        
        XCTAssertEqual(conformance, ["CaseIterable"])
    }
}
