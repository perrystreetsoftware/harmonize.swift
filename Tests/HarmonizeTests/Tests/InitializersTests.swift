import Foundation
import Harmonize
import XCTest

final class InitializersTests: XCTestCase {
    private var harmonize = TestUtils.harmonize(at: "Fixtures/Initializers")
    
    func testAssertCanParseInitializers() throws {
        let initializers = harmonize.initializers()
        XCTAssertEqual(initializers.count, 5)
    }
    
    func testAssertCanParseInitializerModifiers() throws {
        let initializers = harmonize.initializers()
        let modifiers = initializers.flatMap { $0.modifiers }
        
        XCTAssertEqual(
            modifiers,
            [.required, .dynamic, .private]
        )
    }
    
    func testAssertCanParseInitializerAttributes() throws {
        let initializers = harmonize.initializers()
        let attributes = initializers.flatMap { $0.attributes }
        
        XCTAssertEqual(
            attributes,
            [Attribute(name: "objc", annotation: .objc)]
        )
    }
    
    func testAssertCanParseInitializersParams() throws {
        let initializers = harmonize.initializers()
        let params = initializers.flatMap { $0.parameters }
            .map { $0.name }
        
        XCTAssertEqual(params, ["param1", "param2", "param1", "param2", "property", "property", "value"])
    }
    
    
    func testAssertCanParseInitializersFunctions() throws {
        let initializers = harmonize.initializers()
        let functions = initializers.flatMap { $0.functions }
            .map { $0.name }
        
        XCTAssertEqual(functions, ["hold"])
    }
    
    func testAssertCanParseInitializersProperties() throws {
        let initializers = harmonize.initializers()
        let property = initializers.flatMap { $0.properties }.first
        
        XCTAssertEqual(property?.name, "_")
        XCTAssertEqual(property?.isOfInferredType, true)
        XCTAssertEqual(property?.initializerClause?.value, "bar")
    }
}
