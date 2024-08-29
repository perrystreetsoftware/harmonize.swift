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
    
    private func test(f: (ConvertersVisitor) -> Void) {
        let visitor = ConvertersVisitor(viewMode: .sourceAccurate)
        let sourceFile = Parser.parse(source: sourceCode)
        visitor.walk(sourceFile)
        f(visitor)
    }
}

private var sourceCode = """
var name: String = "John", age: Int = 27, lastName: String = "Doe"
var optional: String? = nil
"""
