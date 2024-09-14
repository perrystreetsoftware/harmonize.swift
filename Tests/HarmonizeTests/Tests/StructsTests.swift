import Foundation
import Harmonize
import XCTest

final class StructsTests: XCTestCase {
    private var harmonize = TestUtils.harmonize(at: "Fixtures/Structs")
    
    func testAssertCanParseStructsIncludingNested() throws {
        let structs = harmonize.structs(includeNested: true)
        let structsNames = structs.map { $0.name }
        
        XCTAssertEqual(structs.count, 3)
        XCTAssertEqual(structsNames, ["MyStructItem", "MyStruct", "AttributedStruct"])
    }
    
    func testAssertCanParseNestedStructs() throws {
        let structs = harmonize.structs(includeNested: true)
        let nestedStructs = structs.filter { $0.parent != nil }
        XCTAssertEqual(nestedStructs.count, 1)
        
        let parent = nestedStructs.first?.parent as! Struct
        XCTAssertEqual(parent.name, "MyStruct")
    }
    
    func testAssertCanParseTopLevelStructsOnly() throws {
        let structs = harmonize.structs(includeNested: false)
        let structsNames = structs.map { $0.name }
        
        XCTAssertEqual(structs.count, 2)
        XCTAssertEqual(structsNames.first, "MyStruct")
    }
    
    func testAssertCanParseInheritanceTypesNames() throws {
        let structs = harmonize.structs(includeNested: true)
        let inheritanceTypes = structs.flatMap { $0.inheritanceTypesNames }
        
        XCTAssertEqual(inheritanceTypes, ["MyStructProtocol"])
    }
    
    func testAssertCanParseStructsProperties() throws {
        let structs = harmonize.structs(includeNested: true)
        let properties = structs.map { $0.properties }
        
        let names = properties.flatMap { $0.map { $0.name } }
        let types = properties.flatMap { $0.compactMap { $0.typeAnnotation } }.map { $0.name }
        
        XCTAssertEqual(names, ["prop1", "prop2", "property1", "property2", "property3", "items"])
        XCTAssertEqual(types, ["String", "String", "String", "Int", "Bool", "[MyStructItem]"])
    }
    
    func testAssertCanParseStructsAttributes() throws {
        let structs = harmonize.structs(includeNested: true)
        let attributes = structs.flatMap { $0.attributes }
        
        XCTAssertEqual(attributes.count, 1)
        XCTAssertEqual(
            attributes.first,
            Attribute(name: "dynamicCallable", annotation: .dynamicCallable)
        )
    }
    
    func testAssertCanParseStructsMemberFunctions() throws {
        let function = harmonize.structs(includeNested: true).first { $0.name == "MyStruct" }!.functions.first!
        
        XCTAssertEqual(function.name, "someFunction")
        XCTAssertEqual(function.body, "property2 + 2")
    }

}
