//
//  Attribute.
//
//
//  Created by Lucas Cavalcante on 8/24/24.
//

import Foundation

/// TODO: investigate if it's worth it to make `args` to be type-safe.

public struct Attribute: Equatable {
    public let name: String
    public let annotation: Annotation
    public let arguments: [String]
    
    public init(name: String, annotation: Annotation, arguments: [String] = []) {
        self.name = "@\(name)"
        self.annotation = annotation
        self.arguments = arguments
    }
}

public enum Annotation: String, Equatable {
    // declaration-site attributes
    case attached = "attached"
    case available = "available"
    case backDeployed = "backDeployed"
    case discardableResult = "discardableResult"
    case dynamicCallable = "dynamicCallable"
    case dynamicMemberLookup = "dynamicMemberLookup"
    case freestanding = "freestanding"
    case frozen = "frozen"
    case gkInspectable = "GKInspectable"
    case inlinable = "inlinable"
    case main = "main"
    case nonobjc = "nonobjc"
    case nsApplicationMain = "NSApplicationMain"
    case nsCopying = "NSCopying"
    case nsManaged = "NSManaged"
    case objc = "objc"
    case objcMembers = "objcMembers"
    case preconcurrency = "preconcurrency"
    case propertyWrapper = "propertyWrapper"
    case resultBuilder = "resultBuilder"
    case requiresStoredPropertyInits = "requires_stored_property_inits"
    case testable = "testable"
    case uiApplicationMain = "UIApplicationMain"
    case unchecked = "unchecked"
    case usableFromInline = "usableFromInline"
    case warnUnqualifiedAccess = "warn_unqualified_access"
    case customPropertyWrapper = "customPropertyWrapper"
    
    // type-site attributes
    case autoclosure = "autoclosure"
    case conventionC = "convention(c)"
    case conventionBlock = "convention(block)"
    case conventionSwift = "convention(swift)"
    case escaping = "escaping"
    case sendable = "Sendable"
    
    // "custom" property wrapper from Combine/SwiftUI.
    case appStorage = "AppStorage"
    case binding = "Binding"
    case environment = "Environment"
    case environmentObject = "EnvironmentObject"
    case fetchRequest = "FetchRequest"
    case focusedBinding = "FocusedBinding"
    case focusState = "FocusState"
    case gestureState = "GestureState"
    case observedObject = "ObservedObject"
    case sceneStorage = "SceneStorage"
    case state = "State"
    case stateObject = "StateObject"
    case published = "Published"
    
    public static func from(name: String, typeArgument: String? = nil) -> Self? {
        let unsupportedAttributes = ["inline", "rethrows"]
        
        if name.hasPrefix("_") || unsupportedAttributes.contains(name) {
            return nil
        }
        
        if let typeArgument {
            return Self(rawValue: name + typeArgument) ?? .customPropertyWrapper
        }
        
        return Self(rawValue: name) ?? .customPropertyWrapper
    }
}
