import Foundation
@testable import Harmonize
import XCTest
import SwiftSyntax
import SwiftParser

final class AttributeSyntaxConverterTests: XCTestCase {
    private let visitor = ConvertersVisitor(viewMode: .sourceAccurate)
    private var attributes: [SwiftAttribute] {
        visitor.attributes
    }
    
    func testCanParseSwiftListSyntaxAttributes() throws {
        walk()
        XCTAssertEqual(visitor.attributes.count, 37)
    }
    
    func testCanParseSwiftListSyntaxAttributesArguments() throws {
        walk()
        
        let expectedAttributes: [SwiftAttribute] = [
            .declaration(attribute: .testable, arguments: []),
            .declaration(attribute: .attached, arguments: ["memberAttribute"]),
            .declaration(attribute: .freestanding, arguments: ["declaration"]),
            .declaration(attribute: .backDeployed, arguments: ["iOS 15.0"]),
            .declaration(attribute: .dynamicCallable, arguments: []),
            .declaration(attribute: .dynamicMemberLookup, arguments: []),
            .declaration(attribute: .frozen, arguments: []),
            .declaration(attribute: .main, arguments: []),
            .declaration(attribute: .resultBuilder, arguments: []),
            .customPropertyWrapper(name: "IntArrayBuilder", arguments: []),
            .declaration(attribute: .propertyWrapper, arguments: []),
            .declaration(attribute: .nsApplicationMain, arguments: []),
            .declaration(attribute: .requiresStoredPropertyInits, arguments: []),
            .declaration(attribute: .uiApplicationMain, arguments: []),
            .declaration(attribute: .unchecked, arguments: []),
            .declaration(attribute: .warnUnqualifiedAccess, arguments: []),
            .declaration(attribute: .usableFromInline, arguments: []),
            .declaration(attribute: .objc, arguments: []),
            .declaration(attribute: .nsCopying, arguments: []),
            .declaration(attribute: .nsManaged, arguments: []),
            .declaration(attribute: .preconcurrency, arguments: []),
            .declaration(attribute: .gkInspectable, arguments: []),
            .declaration(attribute: .objc, arguments: ["isEnabled"]),
            .declaration(attribute: .available, arguments: ["iOS 14.0", "*"]),
            .declaration(attribute: .objc, arguments: []),
            .declaration(attribute: .inlinable, arguments: []),
            .declaration(attribute: .discardableResult, arguments: []),
            .declaration(attribute: .objcMembers, arguments: []),
            .type(attribute: .conventionC),
            .type(attribute: .conventionBlock),
            .type(attribute: .conventionSwift),
            .declaration(attribute: .available, arguments: ["*", "noasync"]),
            .customPropertyWrapper(name: "MyWrapper", arguments: []),
            .declaration(attribute: .nonobjc, arguments: []),
            .type(attribute: .escaping),
            .type(attribute: .autoclosure),
            .type(attribute: .sendable),
        ]
        
        XCTAssertEqual(visitor.attributes, expectedAttributes)
    }
    
    private func walk() {
        let sourceFile = Parser.parse(source: sourceCode)
        visitor.walk(sourceFile)
    }
}

private var sourceCode = """
import Foundation
@testable import Harmonize

@attached(memberAttribute)
@freestanding(declaration)
public macro Macro() = #externalMacro(module: "module", type: "type")

@backDeployed(before: iOS 15.0)
public func perform() {
    
}

@dynamicCallable
struct DynamicCallableStruct {
    func dynamicallyCall(withArguments args: [Int]) {
        
    }
}

@dynamicMemberLookup
struct DynamicStruct {
    let dictionary = ["someDynamicMember": 325,
                      "someOtherMember": 787]
    subscript(dynamicMember member: String) -> Int {
        return dictionary[member] ?? 1054
    }
}

@frozen enum State {
    case Looked
    case Unlocked
}

@main struct App {
    static func main() {
        
    }
}

@resultBuilder
struct IntArrayBuilder {
    static func buildBlock(_ components: Int...) -> [Int] {
        []
    }
}

@IntArrayBuilder var intArray: [Int] {
    9
}

@propertyWrapper
struct MyWrapper {
    private var value: String
    
    var wrappedValue: String {
        get { value }
        set { value = newValue }
    }
    
    init(wrappedValue: String) {
        self.value = wrappedValue
    }
}

// won't compile as it doesn't conforms to NSApplicationDelegate
// we're can still parse `NSApplicationMain`
@NSApplicationMain class App2: NSApplicationDelegate {
}

@requires_stored_property_inits
class RandomClass {}

// testing purpose; won't compile.
@UIApplicationMain class Main: UIApplicationDelegate {

}

@rethrows // unsupported
class Proto: @unchecked Sendable {
    @warn_unqualified_access
    func warned() {}
}

@_preInverseGenerics // unsupported
func foo<T: ~Copyable>(_ t: borrowing T) {}

@usableFromInline
func usable(f: (() -> () -> Int) -> Void) {
    let input = { 9 }
    f { input }
}

@objc
class MyClass: NSObject {
    @NSCopying var copying: NSColor = .controlColor
    @NSManaged var managed: NSColor
    
    @preconcurrency
    func prefetch() {
        
    }
    
    @GKInspectable
    var gameKitDeclr: String { "" }
    
    @objc(isEnabled)
    var enabled: Bool {
        return true
    }
    
    @available(iOS 14.0, *)
    @objc dynamic func someMethod() {}
    
    @inline(__always) // unsupported
    func alwaysInlined() {}
    
    @inlinable
    func inlinableMethod() {}
    
    @discardableResult
    func performTask() -> Bool {
        return true
    }
    
    @objcMembers
    class MyOtherClass {}
    
    func cfunc() -> (@convention(c) () -> Void)? {
        return nil
    }
    
    func objcfunc() -> (@convention(block) () -> Void)? {
        return nil
    }
    
    func swiftfunc() -> (@convention(swift) () -> Void)? {
        return nil
    }
    
    // unsupported
    @_silgen_name("foo")
    func silgenNameMethod() {}
    
    // unsupported
    @_originallyDefinedIn(module: "MyFramework", iOS 12.0)
    func originallyDefinedMethod() {}
    
    @available(*, noasync)
    func noAsyncMethod() {}
    
    @MyWrapper
    @nonobjc
    var wrappedProperty: String = ""
    
    func escapingClosure(_ closure: @escaping () -> Void) {}
    
    func autoclosureExample(_ condition: @autoclosure () -> Bool) {
        if condition() {
            print("Condition met")
        }
    }
    
    func sendable(_ f: @Sendable () -> Int) {
        
    }
}
"""
