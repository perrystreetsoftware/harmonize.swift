import Foundation
@testable import Harmonize
import XCTest
import SwiftSyntax
import SwiftParser

final class AttributeSyntaxConverterTests: XCTestCase {
    private let visitor = ConvertersVisitor(viewMode: .sourceAccurate)
    private var attributes: [Attribute] {
        visitor.attributes
    }
    
    func testCanParseSwiftListSyntaxAttributesArguments() throws {
        walk()
        
        let expectedAttributes: [Attribute] = [
            Attribute(name: "testable", annotation: .testable, arguments: []),
            Attribute(name: "attached", annotation: .attached, arguments: ["memberAttribute"]),
            Attribute(name: "freestanding", annotation: .freestanding, arguments: ["declaration"]),
            Attribute(name: "backDeployed", annotation: .backDeployed, arguments: ["iOS 15.0"]),
            Attribute(name: "dynamicCallable", annotation: .dynamicCallable),
            Attribute(name: "dynamicMemberLookup", annotation: .dynamicMemberLookup),
            Attribute(name: "frozen", annotation: .frozen),
            Attribute(name: "main", annotation: .main),
            Attribute(name: "resultBuilder", annotation: .resultBuilder),
            Attribute(name: "IntArrayBuilder", annotation: .customPropertyWrapper),
            Attribute(name: "propertyWrapper", annotation: .propertyWrapper),
            Attribute(name: "NSApplicationMain", annotation: .nsApplicationMain),
            Attribute(name: "requires_stored_property_inits", annotation: .requiresStoredPropertyInits),
            Attribute(name: "UIApplicationMain", annotation: .uiApplicationMain),
            Attribute(name: "unchecked", annotation: .unchecked),
            Attribute(name: "warn_unqualified_access", annotation: .warnUnqualifiedAccess),
            Attribute(name: "usableFromInline", annotation: .usableFromInline),
            Attribute(name: "objc", annotation: .objc),
            Attribute(name: "NSCopying", annotation: .nsCopying),
            Attribute(name: "NSManaged", annotation: .nsManaged),
            Attribute(name: "preconcurrency", annotation: .preconcurrency),
            Attribute(name: "GKInspectable", annotation: .gkInspectable),
            Attribute(name: "objc", annotation: .objc, arguments: ["isEnabled"]),
            Attribute(name: "available", annotation: .available, arguments: ["iOS 14.0", "*"]),
            Attribute(name: "objc", annotation: .objc),
            Attribute(name: "inlinable", annotation: .inlinable),
            Attribute(name: "discardableResult", annotation: .discardableResult),
            Attribute(name: "objcMembers", annotation: .objcMembers),
            Attribute(name: "convention(c)", annotation: .conventionC),
            Attribute(name: "convention(block)", annotation: .conventionBlock),
            Attribute(name: "convention(swift)", annotation: .conventionSwift),
            Attribute(name: "available", annotation: .available, arguments: ["*", "noasync"]),
            Attribute(name: "MyWrapper", annotation: .customPropertyWrapper),
            Attribute(name: "nonobjc", annotation: .nonobjc),
            Attribute(name: "escaping", annotation: .escaping),
            Attribute(name: "autoclosure", annotation: .autoclosure),
            Attribute(name: "Sendable", annotation: .sendable),
            Attribute(name: "Published", annotation: .published),
            Attribute(name: "Published", annotation: .published),
            Attribute(name: "State", annotation: .state),
            Attribute(name: "StateObject", annotation: .stateObject),
            Attribute(name: "ObservedObject", annotation: .observedObject),
            Attribute(name: "EnvironmentObject", annotation: .environmentObject),
            Attribute(name: "Environment", annotation: .environment, arguments: ["\\.colorScheme"]),
            Attribute(name: "Binding", annotation: .binding),
            Attribute(name: "AppStorage", annotation: .appStorage, arguments: ["user_preference"]),
            Attribute(name: "SceneStorage", annotation: .sceneStorage, arguments: ["draft_content"]),
            Attribute(name: "GestureState", annotation: .gestureState),
            Attribute(name: "FocusState", annotation: .focusState),
            Attribute(name: "FocusedBinding", annotation: .focusedBinding, arguments: ["\\.isFocusedField"]),
            Attribute(name: "FetchRequest", annotation: .fetchRequest, arguments: ["entity: MyEntity.entity()", "sortDescriptors: []"]),
            Attribute(name: "main", annotation: .main),
            Attribute(name: "StateObject", annotation: .stateObject)
        ]
        
        (0..<visitor.attributes.count).forEach { index in
            XCTAssertEqual(visitor.attributes[index], expectedAttributes[index])
        }
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

// SwiftUI

import SwiftUI
import Combine

class ExampleViewModel: ObservableObject {
    @Published var publishedValue: String = "Published Value"
}

class GlobalSettings: ObservableObject {
    @Published var isDarkMode: Bool = false
}

struct ContentView: View {
    // SwiftUI property wrappers
    @State private var stateValue: String = "Initial State"
    @StateObject private var stateObjectViewModel = ExampleViewModel()
    @ObservedObject private var observedObjectViewModel = ExampleViewModel()
    @EnvironmentObject private var globalSettings: GlobalSettings
    @Environment(\\.colorScheme) var colorScheme: ColorScheme
    @Binding private var bindingValue: String
    @AppStorage("user_preference") private var userPreference: Bool = false
    @SceneStorage("draft_content") private var draftContent: String = ""
    @GestureState private var gestureActive = false
    @FocusState private var isFocused: Bool
    @FocusedBinding(\\.isFocusedField) private var focusedFieldBinding: Binding<Bool>?

    @FetchRequest(entity: MyEntity.entity(), sortDescriptors: [])
    private var fetchRequestResults: FetchedResults<MyEntity>

    var body: some View {
        VStack {
            Text("State Value: \\(stateValue)")
            Text("Published Value: \\(observedObjectViewModel.publishedValue)")
            Text("User Preference: \\(userPreference ? "On" : "Off")")
            Text("Draft Content: \\(draftContent)")
            Text("Color Scheme: \\(colorScheme == .dark ? "Dark" : "Light")")
            Text("Is Focused: \\(isFocused ? "Yes" : "No")")
            Text("Gesture Active: \\(gestureActive ? "Yes" : "No")")
            Text("Global Dark Mode: \\(globalSettings.isDarkMode ? "On" : "Off")")
            
            Button("Toggle Focus") {
                isFocused.toggle()
            }

            Button("Toggle User Preference") {
                userPreference.toggle()
            }
        }
        .onAppear {
            stateValue = "Updated State"
        }
        .focused($isFocused)
        .gesture(DragGesture().updating($gestureActive) { value, state, _ in
            state = true
        })
    }
}

extension MyEntity: Identifiable {}

struct FocusFieldKey: FocusedValuesKey {
    static var defaultValue: Binding<Bool>? = nil
}

extension FocusedValues {
    var isFocusedField: Binding<Bool>? {
        get { self[FocusFieldKey.self] }
        set { self[FocusFieldKey.self] = newValue }
    }
}

@main
struct ExampleApp: App {
    @StateObject private var globalSettings = GlobalSettings()

    var body: some Scene {
        WindowGroup {
            ContentView(bindingValue: .constant("Binding Value"))
                .environmentObject(globalSettings)
        }
    }
}

"""
