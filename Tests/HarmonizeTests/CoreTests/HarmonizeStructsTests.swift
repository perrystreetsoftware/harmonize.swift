import Foundation
import Harmonize
import XCTest

final class HarmonizeStructsTests: XCTestCase {
    private var harmonize: Harmonize {
        HarmonizeUtils().appendingPath("StructsFixture").harmonize()
    }
    
    func testAssertCanParseStructsIncludingNested() throws {
        let structs = harmonize.structs()
        let structsNames = structs.map { $0.name }
        
        XCTAssertEqual(structs.count, 3)
        XCTAssertEqual(structsNames, ["MyStruct", "MyStructItem", "AttributedStruct"])
    }
    
    func testAssertCanParseNestedClasses() throws {
        let structs = harmonize.structs()
        let nestedStructs = structs.filter { $0.parent != nil }
        XCTAssertEqual(nestedStructs.count, 1)
        XCTAssertEqual(nestedStructs.first?.parent?.name, "MyStruct")
    }
    
    func testAssertCanParseTopLevelStructsOnly() throws {
        let structs = harmonize.structs(includeNested: false)
        let structsNames = structs.map { $0.name }
        
        XCTAssertEqual(structs.count, 2)
        XCTAssertEqual(structsNames.first, "MyStruct")
    }
    
    func testAssertCanParseInheritanceTypesNames() throws {
        let structs = harmonize.structs(includeNested: true)
        let inheritanceTypes = structs.compactMap { $0.inheritanceTypesNames }.flatten()
        
        XCTAssertEqual(inheritanceTypes, ["MyStructProtocol"])
    }
    
    func testAssertCanParseStructsProperties() throws {
        let structs = harmonize.structs(includeNested: true)
        let properties = structs.map { $0.properties }
        
        let names = properties.flatMap { $0.map { $0.name } }
        let types = properties.flatMap { $0.map { $0.typeAnnotation }}
        
        XCTAssertEqual(names, ["property1", "property2", "property3", "items", "prop1", "prop2"])
        XCTAssertEqual(types, ["String", "Int", "Bool", "[MyStructItem]", "String", "String"])
    }
    
    func testAssertCanParseStructsAttributes() throws {
        let structs = harmonize.structs()
        let attributes = structs.flatMap { $0.attributes }
        
        XCTAssertEqual(attributes.count, 1)
        XCTAssertEqual(
            attributes,
            [
                .declaration(attribute: .dynamicCallable, arguments: [])
            ]
        )
    }
    
    func testAssertCanParseStructsMemberFunctions() throws {
        let function = structByName("MyStruct").functions.first!
        
        let body = """
        { property2 + 2 }
        """
        
        XCTAssertEqual(function.name, "someFunction")
        XCTAssertEqual(function.body, body)
    }
    
    private func structByName(_ name: String) -> SwiftStruct {
        harmonize.structs().first { $0.name == name }!
    }
}
