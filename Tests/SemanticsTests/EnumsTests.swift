//
//  EnumsTests.swift
//  Harmonize
//
//  Copyright (c) Perry Street Software 2024. All Rights Reserved.
//

import Foundation
import Semantics
import XCTest

final class EnumsTests: XCTestCase {
    private var sourceSyntax = """
    public enum Role: Equatable {
        @usableFromInline
        enum Merch: String {
            case svet = "svet"
            case esac = "esac"
        }
        
        case noop(String)
        case pump(_ firstName: String)
        
        private func merch() -> Merch {
            switch self {
            case .noop(_):
                    .esac
            case .pump(_):
                    .svet
            }
        }
        
        static func from(value: String) -> Self {
            .pump(value)
        }
        
        var label: String {
            switch self {
            case .noop(let string):
                string
            case .pump(let labelString):
                labelString
            }
        }
    }

    public enum Order: String {
        case a, b, c, d = "Di", e, f, g
    }
    """.parsed()
    
    private var visitor = DeclarationsCollector()
    
    override func setUp() {
        visitor.walk(sourceSyntax)
    }
    
    func testParseEnumsIncludingNested() throws {
        let enums = visitor.enums.map { $0.name }
        
        XCTAssertEqual(enums.count, 3)
        XCTAssertEqual(enums, ["Role", "Merch", "Order"])
    }
    
    func testParseInheritanceClause() throws {
        let enumsInheritanceClauses = visitor.enums.map { $0.inheritanceTypesNames }
        XCTAssertEqual(enumsInheritanceClauses, [["Equatable"], ["String"], ["String"]])
    }
    
    func testParseEnumsProperties() throws {
        let enums = visitor.enums
        let properties = enums.flatMap { $0.variables }
        let names = properties.map { $0.name }
        let parent = properties.map { ($0.parent as? Enum)?.name }
        let getter = properties.first?.getter
        
        XCTAssertEqual(properties.count, 1)
        XCTAssertEqual(names, ["label"])
        XCTAssertEqual(parent, ["Role"])
        XCTAssertNotNil(getter)
    }
    
    func testParseEnumsAttributes() throws {
        let enums = visitor.enums
        let attributes = enums.flatMap { $0.attributes }.map { $0.annotation }
        
        XCTAssertEqual(attributes.count, 1)
        XCTAssertEqual(attributes.first, .usableFromInline)
    }
    
    func testParseEnumsMemberFunctions() throws {
        let functions = visitor.enums.flatMap { $0.functions }.map { $0.name }
        
        XCTAssertEqual(functions.count, 2)
        XCTAssertEqual(functions, ["merch", "from"])
    }
    
    func testParseEnumCases() throws {
        let cases = visitor.enums
            .flatMap { $0.cases }
            .map { $0.name }
        
        XCTAssertEqual(cases.count, 11)
    }
    
    func testParseEnumCasesParameters() throws {
        let cases = visitor.enums.first { $0.name == "Role" }.flatMap { $0.cases }
        let first = cases?.first
        let second = cases?.last
        
        XCTAssertEqual(first?.name, "noop")
        XCTAssertEqual(first?.parameters.first?.label, "")
        XCTAssertEqual(first?.parameters.first?.typeAnnotation?.name, "String")
    
        XCTAssertEqual(second?.name, "pump")
        XCTAssertEqual(second?.parameters.last?.label, "_ firstName")
    }
    
    func testParseInlineEnumCases() throws {
        let cases = visitor.enums.last.flatMap { $0.cases }?.map { $0.name }
        XCTAssertEqual(cases, ["a", "b", "c", "d", "e", "f", "g"])
    }
    
    func testParseEnumCasesInitializers() throws {
        let initializers = visitor.enums.last.flatMap { $0.cases }?.map { $0.initializerClause?.value }
        XCTAssertEqual(initializers, [nil, nil, nil, "Di", nil, nil, nil])
    }
}
