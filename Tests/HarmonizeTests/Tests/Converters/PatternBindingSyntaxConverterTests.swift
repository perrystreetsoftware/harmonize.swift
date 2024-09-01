import Foundation
@testable import Harmonize
import XCTest
import SwiftSyntax
import SwiftParser

final class PatternBindingSyntaxConverterTests: XCTestCase {
    func testCanParsePatterBindingIdentifiers() throws {
        test {
            XCTAssertEqual(
                $0.identifiers,
                [
                    "name",
                    "age",
                    "lastName",
                    "optional"
                ]
            )
        }
    }
    
    func testCanParsePatternBindingTypes() throws {
        test {
            XCTAssertEqual(
                $0.types,
                [
                    TypeAnnotation(name: "String", isOptional: false),
                    TypeAnnotation(name: "Int", isOptional: false),
                    TypeAnnotation(name: "String", isOptional: false),
                    TypeAnnotation(name: "String?", isOptional: true)
                ]
            )
        }
    }
    
    func testCanParsePatternBindingInitializers() throws {
        test {
            XCTAssertEqual(
                $0.initializers,
                [
                    InitializerClause(value: "John"),
                    InitializerClause(value: "27"),
                    InitializerClause(value: "Doe"),
                    InitializerClause(value: "nil")
                ]
            )
        }
    }
    
    func testCanParsePatternBindingWithOptionalTypes() throws {
        test {
            XCTAssertEqual(
                $0.types.last!,
                TypeAnnotation(name: "String?", isOptional: true)
            )
        }
    }
    
    func testCanParsePatternBindingAccessors() throws {
        test(accessors) {
            XCTAssertEqual(
                $0.accessors,
                [
                    AccessorBlock(modifier: .getter, body: "lcszc"),
                    AccessorBlock(modifier: .get),
                    AccessorBlock(modifier: .set),
                    AccessorBlock(modifier: .get, body: "return 42"),
                    AccessorBlock(modifier: .set, body: "settable = newValue"),
                    AccessorBlock(modifier: .willSet, body: ""),
                    AccessorBlock(modifier: .didSet, body: ""),
                ]
            )
        }
    }
    
    private func test(_ source: String = sourceCode, f: (ConvertersVisitor) -> Void) {
        let visitor = ConvertersVisitor(viewMode: .sourceAccurate)
        let sourceFile = Parser.parse(source: source)
        visitor.walk(sourceFile)
        f(visitor)
    }
}

private var sourceCode = """
var name: String = "John", age: Int = 27, lastName: String = "Doe"
var optional: String? = nil
"""

private var accessors = """
var name: String {
  "lcszc"
}

public protocol Proto {
  var property: String { get set }
}

var settable: Int = 0

var example: Int {
    get { return 42 }
    set { settable = newValue }
}

var anotherExample: Int = 0 {
    willSet {
        
    }

    didSet {
    }
}
"""
