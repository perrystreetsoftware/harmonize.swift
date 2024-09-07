import Foundation
import Harmonize
import XCTest

final class ClassesTests: XCTestCase {
    private var harmonize: Harmonize {
        TestUtils.harmonize(atFixtures: "Classes")
    }
    
    func testAssertCanParseClassesIncludingNested() throws {
        let classes = harmonize.classes()
        let classesNames = classes.map { $0.name }
        
        XCTAssertEqual(classes.count, 3)
        XCTAssertEqual(classesNames, ["StateSample", "MyFile", "MyClass2"])
    }
    
    func testAssertCanParseNestedClasses() throws {
        let classes = harmonize.classes()
        
        let stateSample = classes.filter { $0.parent != nil }.first
        
        XCTAssertNotNil(stateSample)
        
        let parent = stateSample?.parent as? Class
        XCTAssertEqual(parent?.name, "MyFile")
    }
    
    func testAssertCanParseTopLevelClassesOnly() throws {
        let classes = harmonize.classes(includeNested: false)
        let classesNames = classes.map { $0.name }
        
        XCTAssertEqual(classes.count, 2)
        XCTAssertEqual(classesNames.first, "MyFile", "MyClass2")
    }
    
    func testAssertCanParseInheritanceTypesNames() throws {
        let classes = harmonize.classes(includeNested: false)
        let inheritanceTypes = classes.map { $0.inheritanceTypesNames }
        
        XCTAssertEqual(inheritanceTypes, [["NSObject", "MyProtocol", "Sendable"], ["MyProtocol"]])
    }
    
    func testAssertCanParseClassesProperties() throws {
        let classes = harmonize.classes()
        let properties = classes.flatMap { $0.properties }
        let names = properties.map { $0.name }
        let parent = properties.map { ($0.parent as? Class)?.name }
        let values = properties.compactMap { $0.initializerClause }.map { $0.value }
        
        XCTAssertEqual(properties.count, 3)
        XCTAssertEqual(names, ["property", "y", "property"])
        XCTAssertEqual(parent, ["MyFile", "MyFile", "MyClass2"])
        XCTAssertEqual(values, ["x", "0", "y"])
    }
    
    func testAssertCanParseClassesAttributes() throws {
        let classes = harmonize.classes()
        let attributes = classes.flatMap { $0.attributes }
        
        XCTAssertEqual(attributes.count, 2)
        XCTAssertEqual(
            attributes, 
            [
                Attribute(name: "requires_stored_property_inits", annotation: .requiresStoredPropertyInits),
                Attribute(name: "objc", annotation: .objc)
            ]
        )
    }
    
    func testAssertCanParseClassesMemberFunctions() throws {
        let classFunctions = classByName("MyClass2").functions
        XCTAssertEqual(classFunctions.count, 2)
        XCTAssertEqual(classFunctions.map { $0.name }, ["first", "second"])
        
        XCTAssertEqual(
            classFunctions.map { $0.body },
            [
                "var _ = 42",
                "var _ = 44"
            ]
        )
    }
    
    private func classByName(_ name: String) -> Class {
        harmonize.classes().first { $0.name == name }!
    }
}
