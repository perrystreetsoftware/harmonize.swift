//
//  EnumsTests.swift
//
//
//  Created by Lucas Cavalcante on 8/29/24.
//
import Foundation
import Harmonize
import XCTest

final class EnumsTests: XCTestCase {
    private var harmonize: Harmonize {
        HarmonizeUtils().appendingPath("Fixtures/Enums").harmonize()
    }
    
    func testAssertCanParseNestedEnums() throws {
        let enums = harmonize.enums().map { $0.name }
        
        XCTAssertEqual(enums.count, 3)
        XCTAssertEqual(enums, ["Merch", "Role", "Order"])
    }
    
    func testAssertCanParseTopLevelEnums() throws {
        let enums = harmonize.enums(includeNested: false).map { $0.name }
        
        XCTAssertEqual(enums, ["Role", "Order"])
    }
    
    func testAssertCanParseInheritanceClause() throws {
        let enumsInheritanceClauses = harmonize.enums(includeNested: false).map { $0.inheritanceTypesNames
        }
        
        XCTAssertEqual(enumsInheritanceClauses, [["Equatable"], ["String"]])
    }
    
    func testAssertCanParseEnumsProperties() throws {
        let enums = harmonize.enums()
        let properties = enums.flatMap { $0.properties }
        let names = properties.map { $0.name }
        let parent = properties.map { ($0.parent as? Enum)?.name }
        let accessor = properties.first?.accessorBlocks.first
        
        XCTAssertEqual(properties.count, 1)
        XCTAssertEqual(names, ["label"])
        XCTAssertEqual(parent, ["Role"])
        XCTAssertEqual(accessor?.modifier, .getter)
    }
    
    func testAssertCanParseEnumsAttributes() throws {
        let enums = harmonize.enums()
        let attributes = enums.flatMap { $0.attributes }.map { $0.annotation }
        
        XCTAssertEqual(attributes.count, 1)
        XCTAssertEqual(attributes.first, .usableFromInline)
    }
    
    func testAssertCanParseEnumsMemberFunctions() throws {
        let functions = harmonize.enums().flatMap { $0.functions }.map { $0.name }
        
        XCTAssertEqual(functions.count, 2)
        XCTAssertEqual(functions, ["merch", "from"])
    }
    
    func testAssertCanParseEnumCases() throws {
        let cases = harmonize.enums()
            .flatMap { $0.cases }
            .map { $0.name }
        
        XCTAssertEqual(cases.count, 11)
    }
    
    func testAssertCanParseEnumCasesParameters() throws {
        let cases = harmonize.enums().first { $0.name == "Role" }.flatMap { $0.cases }
        let first = cases?.first
        let second = cases?.last
        
        XCTAssertEqual(first?.name, "noop")
        XCTAssertEqual(first?.parameters.first?.label, nil)
        XCTAssertEqual(first?.parameters.first?.typeAnnotation?.name, "String")
    
        XCTAssertEqual(second?.name, "pump")
        XCTAssertEqual(second?.parameters.last?.label, "_ firstName")
    }
    
    func testAssertCanParseInlineEnumCases() throws {
        let cases = harmonize.enums().last.flatMap { $0.cases }?.map { $0.name }
        XCTAssertEqual(cases, ["a", "b", "c", "d", "e", "f", "g"])
    }
    
    func testAssertCanParseEnumCasesInitializers() throws {
        let initializers = harmonize.enums().last.flatMap { $0.cases }?.map { $0.initializerClause?.value }
        XCTAssertEqual(initializers, [nil, nil, nil, "Di", nil, nil, nil])
    }
}
