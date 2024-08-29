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
                    SwiftIdentifier(name: "name"),
                    SwiftIdentifier(name: "age"),
                    SwiftIdentifier(name: "lastName"),
                    SwiftIdentifier(name: "optional")
                ]
            )
        }
    }
    
    func testCanParsePatternBindingTypes() throws {
        test {
            XCTAssertEqual(
                $0.types,
                [
                    SwiftTypeAnnotation(name: "String", isOptional: false),
                    SwiftTypeAnnotation(name: "Int", isOptional: false),
                    SwiftTypeAnnotation(name: "String", isOptional: false),
                    SwiftTypeAnnotation(name: "String?", isOptional: true)
                ]
            )
        }
    }
    
    func testCanParsePatternBindingInitializers() throws {
        test {
            XCTAssertEqual(
                $0.initializers,
                [
                    SwiftInitializerClause(value: "John"),
                    SwiftInitializerClause(value: "27"),
                    SwiftInitializerClause(value: "Doe"),
                    SwiftInitializerClause(value: "nil")
                ]
            )
        }
    }
    
    func testCanParsePatternBindingWithOptionalTypes() throws {
        test {
            XCTAssertEqual(
                $0.types.last!,
                SwiftTypeAnnotation(name: "String?", isOptional: true)
            )
        }
    }
    
    func testCanParsePatternBindingAccessors() throws {
        test(accessors) {
            XCTAssertEqual(
                $0.accessors,
                [
                    SwiftAccessor(modifier: .getter, body: "lcszc"),
                    SwiftAccessor(modifier: .get),
                    SwiftAccessor(modifier: .set),
                    SwiftAccessor(modifier: .get, body: "return 42"),
                    SwiftAccessor(modifier: .set, body: "settable = newValue"),
                    SwiftAccessor(modifier: .willSet, body: ""),
                    SwiftAccessor(modifier: .didSet, body: ""),
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
