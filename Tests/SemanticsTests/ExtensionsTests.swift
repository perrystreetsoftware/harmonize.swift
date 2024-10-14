//
//  ExtensionsTests.swift
//  Harmonize
//
//  Copyright (c) Perry Street Software 2024. All Rights Reserved.
//

import Foundation
import HarmonizeSemantics
import XCTest

final class ExtensionsTests: XCTestCase {
    private var sourceSyntax = """
    fileprivate extension Properties {
        func mergeThemAll() -> String {
            example2 + example3 + example9
        }
        
        convenience init(param: String) {
            self.init()
        }
    }

    extension Role: CaseIterable {
        public static var allCases: [Role] {
            [.noop(""), .pump("")]
        }
    }
    """.parsed()
    
    private lazy var visitor = {
        DeclarationsCollector(
            sourceCodeLocation: SourceCodeLocation(
                sourceFilePath: nil,
                sourceFileTree: sourceSyntax
            )
        )
    }()
    
    override func setUp() {
        visitor.walk(sourceSyntax)
    }

    func testParseExtensions() throws {
        let extensions = visitor.extensions
        XCTAssertEqual(extensions.count, 2)
    }
    
    func testParseExtensionsTypeNames() throws {
        let extensions = visitor.extensions
        let names = extensions.map { $0.typeAnnotation?.name }
        
        XCTAssertEqual(names, ["Properties", "Role"])
    }

    func testParseExtensionsModifiers() throws {
        let modifiers = visitor.extensions.flatMap { $0.modifiers }
        XCTAssertEqual(modifiers, [.fileprivate])
    }
    
    func testParseExtensionsFunctions() throws {
        let extensions = visitor.extensions
        let functions = extensions.flatMap { $0.functions }
        
        XCTAssertEqual(functions.count, 1)
        XCTAssertEqual(functions.first?.name, "mergeThemAll")
    }
    
    func testParseExtensionsProperties() throws {
        let extensions = visitor.extensions
        let properties = extensions.flatMap { $0.variables }
        
        XCTAssertEqual(properties.count, 1)
        XCTAssertEqual(properties.first?.name, "allCases")
    }
    
    func testParseExtensionsInitializers() throws {
        let extensions = visitor.extensions
        let initializers = extensions.flatMap { $0.initializers }
        
        XCTAssertEqual(initializers.count, 1)
        XCTAssertEqual(initializers.first?.modifiers, [.convenience])
    }
    
    func testParseExtensionsTypesConformance() throws {
        let extensions = visitor.extensions
        let conformance = extensions.flatMap { $0.inheritanceTypesNames }
        
        XCTAssertEqual(conformance, ["CaseIterable"])
    }
}
