import Foundation
import Harmonize
import XCTest

final class VariablesTests: XCTestCase {
    private var harmonize = TestUtils.harmonize(at: "Fixtures/Variables")

    private var topLevelVariables: [Variable] {
        harmonize.variables(includeNested: false)
    }
    
    func testAssertCanParseTopLevelVariables() throws {
        let names = topLevelVariables.map { $0.name }
        
        XCTAssertEqual(topLevelVariables.count, 5)
        
        let expectedNames = ["property", "immutable", "nullable", "inlineProperty1", "inlineProperty2"]
        XCTAssertEqual(names, expectedNames)
    }
    
    func testAssertCanParseTopLevelVariablesTypes() throws {
        let constants = topLevelVariables.filter { $0.isConstant }.count
        let variables = topLevelVariables.filter { $0.isVariable }.count
        
        XCTAssertEqual(variables, 4)
        XCTAssertEqual(constants, 1)
    }
    
    func testAssertCanParseTopLevelVariablesAnnotations() throws {
        let annotations = topLevelVariables.map { $0.typeAnnotation?.name }
        
        let expectedAnnotations = [
            nil,
            "String",
            "String?",
            "Int",
            "String?"
        ]
        
        XCTAssertEqual(annotations, expectedAnnotations)
    }
    
    func testAssertCanParseTopLevelVariablesInferredAnnotations() throws {
        let inferredVariables = topLevelVariables.filter { $0.isOfInferredType }
        XCTAssertEqual(inferredVariables.count, 1)
    }
    
    func testAssertCanParseTopLevelVariablesPrimitiveValues() throws {
        let initializers = topLevelVariables.map { $0.initializerClause }.map { $0?.value }
        
        let expectedValues = [
            "a",
            "string",
            "nil",
            "2",
            "b",
        ]
        
        XCTAssertEqual(initializers, expectedValues)
    }
    
    func testAssertCanParseTopLevelVariablesImmutability() throws {
        let constantVariables = topLevelVariables.filter { $0.isConstant }

        XCTAssertEqual(constantVariables.count, 1)
    }
    
    func testAssertCanParseVariablesWithOptionalTypes() throws {
        let optionalVariables = topLevelVariables.filter { $0.isOptional }
        XCTAssertEqual(optionalVariables.count, 2)
    }
    
    func testAssertCanParseSingleLineMultipleVariables() throws {
        let exampleClass = harmonize.classes(includeNested: true).first { $0.name == "ExampleClass" }!
        let variables = exampleClass.variables
        
        XCTAssertEqual(
            variables.map { $0.name },
            ["a", "b", "c", "d"]
        )
    }
    
    func testAssertSingleLineMultipleVariablesAreOfTheSameType() throws {
        let exampleClass = harmonize.classes(includeNested: true).first { $0.name == "ExampleClass" }!
        let variables = exampleClass.variables
        
        XCTAssert(
            variables.map { $0.typeAnnotation?.name }.allSatisfy { $0 == "Double" }
        )
    }
    
    func testAssertCanParseCustomTypeVariables() throws {
        let mainClass = harmonize.classes(includeNested: true).first { $0.name == "Main" }!
        let variables = mainClass.variables
        
        XCTAssertEqual(
            variables.map { $0.typeAnnotation?.name },
            ["MyClassType", "MyClassType"]
        )
    }
    
    func testAssertCanParseCustomTypeVariablesInitializer() throws {
        let mainClass = harmonize.classes(includeNested: true).first { $0.name == "Main" }!
        let variables = mainClass.variables
        
        XCTAssertEqual(
            variables.map { $0.initializerClause?.value },
            ["MyClassType(value: 2)", nil]
        )
    }
    
    func testAssertCanParseVariablesModifiers() throws {
        let variables = harmonize.variables(includeNested: true)
            .filter { ($0.parent as? Class)?.name == "Properties" }
        
        let modifiers = variables.map { $0.modifiers }
        
        let expectedModifiers: [[Modifier]] = [
            [.private],
            [.public],
            [.internal],
            [.fileprivate],
            [.open],
            [.public, .weak],
            [.unowned],
            [.fileprivate, .lazy],
            [.final],
            [.static],
            [],
            [],
            []
        ]
        
        XCTAssertEqual(modifiers, expectedModifiers)
    }
    
    func testAssertCanParseVariablesAttributes() throws {
        let variables = harmonize.variables(includeNested: true)
        let attributes = variables.flatMap { $0.attributes }
        
        let expectedAttributes: [Attribute] = [
            Attribute(name: "available", annotation: .available, arguments: ["*", "renamed: example11"]),
            Attribute(name: "objc", annotation: .objc),
            Attribute(name: "Published", annotation: .published),
            Attribute(name: "Published", annotation: .published),
        ]
        
        XCTAssertEqual(
            attributes,
            expectedAttributes
        )
    }
    
    func testAssertCanParseVariablesAccessorsBody() throws {
        let variables = harmonize.variables(includeNested: true)
        let accessors = variables.flatMap { $0.accessorBlocks }.map { $0.body }
        
        XCTAssertEqual(accessors.count, 3)
        XCTAssertEqual(
            accessors,
            ["9", "return example12", "example12 = newValue"]
        )
    }
    
    func testAssertCanParseVariablesAccessorsText() throws {
        let variables = harmonize.variables(includeNested: true)
        let accessors = variables.flatMap { $0.accessorBlocks }.map { $0.body }
        
        XCTAssertEqual(accessors.count, 3)
        XCTAssertEqual(
            accessors,
            [
                "9",
                "return example12",
                "example12 = newValue"
            ]
        )
    }
    
    func testAssertCanParseVariablesAccessorsModifier() throws {
        let variables = harmonize.variables(includeNested: true)
        let accessors = variables.flatMap { $0.accessorBlocks }.map { $0.modifier }
        
        XCTAssertEqual(accessors.count, 3)
        XCTAssertEqual(accessors, [.getter, .get, .set])
    }
    
    func testAssertCanParseVariablesWrapper() throws {
        let variables = harmonize.variables(includeNested: true)
            .filter { ($0.parent as? Class)?.name == "MyViewModel" }
        
        let attributes = variables.flatMap { $0.attributes }
        
        XCTAssertEqual(attributes.count, 2)
        XCTAssertEqual(
            attributes,
            [
                Attribute(name: "Published", annotation: .published),
                Attribute(name: "Published", annotation: .published)
            ]
        )
    }
    
    func testAssertCanParseVariablesAccessorsModifiers() throws {
        let variables = harmonize.variables(includeNested: true)
            .filter { ($0.parent as? Class)?.name == "MyViewModel" }
        
        let modifiers = variables.flatMap { $0.modifiers }.map { $0}
        
        XCTAssertEqual(modifiers.count, 3)
        XCTAssertEqual(modifiers, [.public, .public, .privateSet])
    }
}
