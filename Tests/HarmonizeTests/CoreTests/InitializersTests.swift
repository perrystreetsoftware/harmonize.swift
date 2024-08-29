import Foundation
import Harmonize
import XCTest

final class InitializersTests: XCTestCase {
    private var harmonize: Harmonize {
        HarmonizeUtils().appendingPath("InitializersFixture").harmonize()
    }
    
    func testAssertCanParseInitializers() throws {
        let initializers = harmonize.declarations().as(SwiftClass.self)
        XCTAssertEqual(initializers.count, 5)
    }
    
    func testAssertCanParseInitializerModifiers() throws {
        let initializers = harmonize.declarations().as(SwiftInitializer.self)
        let modifiers = initializers.flatMap { $0.modifiers }
        
        XCTAssertEqual(
            modifiers,
            [.required, .private, .dynamic]
        )
    }
    
    func testAssertCanParseInitializerAttributes() throws {
        let initializers = harmonize.declarations().as(SwiftInitializer.self)
        let attributes = initializers.flatMap { $0.attributes }
        
        XCTAssertEqual(
            attributes,
            [.declaration(attribute: .objc, arguments: [])]
        )
    }
    
    func testAssertCanParseInitializersParams() throws {
        let initializers = harmonize.declarations().as(SwiftInitializer.self)
        let params = initializers.flatMap { $0.parameters }
            .map { $0.name }
        
        XCTAssertEqual(params, ["param1", "param2", "property", "value"])
    }
    
    
    func testAssertCanParseInitializersFunctions() throws {
        let initializers = harmonize.declarations().as(SwiftInitializer.self)
        let functions = initializers.flatMap { $0.functions }
            .map { $0.name }
        
        XCTAssertEqual(functions, ["hold"])
    }
}
