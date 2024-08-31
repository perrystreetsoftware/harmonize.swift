//
//  ProtocolsTests.swift
//
//
//  Created by Stelios Frantzeskakis on 23/8/24.
//

import Foundation
import Harmonize
import XCTest

final class ProtocolTests: XCTestCase {
    private var harmonize: Harmonize {
        HarmonizeUtils().appendingPath("Fixtures/Protocols").harmonize()
    }
    
    func testAssertCanParseProtocols() throws {
        let protocols = harmonize.protocols(includeNested: false)
        let names = protocols.map { $0.name }
        
        XCTAssertEqual(protocols.count, 5)
        XCTAssertEqual(names, ["DataRepresentable", "Configurable", "NetworkRequestable", "ClassOnlyProtocol", "Throwable"])
    }
    
    func testAssertCanParseProtocolsProperties() throws {
        let protocols = harmonize.protocols()
        let properties = protocols.flatMap { $0.properties }
        
        XCTAssertEqual(properties.count, 3)
        XCTAssertEqual(properties.map { $0.name }, ["name", "name", "property"])
    }
    
    func testAssertCanParseNestedProtocols() throws {
        let protocols = harmonize.protocols()
        XCTAssertEqual(protocols.count, 7)
    }
    
    func testAssertCanParseNestedClassesProtocols() throws {
        let nestedProtocol = harmonize.protocols().first { $0.parent != nil }!
        
        XCTAssertEqual(nestedProtocol.name, "NamedDelegate")
        XCTAssertEqual(nestedProtocol.parent!.name, "NestedProtocolInClass")
    }
    
    func testAssertCanParseNestedStructsProtocols() throws {
        let nestedProtocol = harmonize.protocols().last { $0.parent != nil }!
        
        XCTAssertEqual(nestedProtocol.name, "NamedDelegate")
        XCTAssertEqual(nestedProtocol.parent!.name, "NestedProtocolInStruct")
    }
    
    func testAssertCanParseProtocolsAttributes() throws {
        let attributedProtocols = harmonize.protocols().filter { !$0.attributes.isEmpty }
        XCTAssertEqual(attributedProtocols.count, 2)
        XCTAssertEqual(
            attributedProtocols.flatMap { $0.attributes },
            [
                .declaration(attribute: .objc, arguments: []),
                .declaration(attribute: .objc, arguments: [])
            ]
        )
    }
    
    func testAssertCanParseProtocolMemberFunctions() throws {
        let function = protocolByName("NetworkRequestable").functions.first!
        XCTAssertEqual(function.name, "someMethod")
        XCTAssertEqual(function.body, nil)
        XCTAssertEqual(function.returnClause, .absent)
        XCTAssertTrue(function.parameters.isEmpty)
    }
    
    private func protocolByName(_ name: String) -> ProtocolDeclaration {
        harmonize.protocols().first { $0.name == name }!
    }
}
