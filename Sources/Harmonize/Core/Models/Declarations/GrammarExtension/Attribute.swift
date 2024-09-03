//
//  Attribute.
//
//
//  Created by Lucas Cavalcante on 8/24/24.
//

import Foundation

/// TODO: investigate if it's worth it to make `args` to be type-safe.

public struct Attribute: Equatable {
    let name: String
    let annotation: Annotation
    let arguments: [String]
    
    public init(name: String, annotation: Annotation, arguments: [String] = []) {
        self.name = "@\(name)"
        self.annotation = annotation
        self.arguments = arguments
    }
}

public enum Annotation: Equatable {
    // declaration-site attributes
    case attached
    case available
    case backDeployed
    case discardableResult
    case dynamicCallable
    case dynamicMemberLookup
    case freestanding
    case frozen
    case gkInspectable
    case inlinable
    case main
    case nonobjc
    case nsApplicationMain
    case nsCopying
    case nsManaged
    case objc
    case objcMembers
    case preconcurrency
    case propertyWrapper
    case resultBuilder
    case requiresStoredPropertyInits
    case testable
    case uiApplicationMain
    case unchecked
    case usableFromInline
    case warnUnqualifiedAccess
    case customPropertyWrapper
    
    // type-site attributes
    case autoclosure
    case conventionC
    case conventionBlock
    case conventionSwift
    case escaping
    case sendable
    
    // "custom" property wrapper from Combine/SwiftUI.
    case appStorage
    case binding
    case environment
    case environmentObject
    case fetchRequest
    case focusedBinding
    case focusState
    case gestureState
    case observedObject
    case sceneStorage
    case state
    case stateObject
    case published
    
    public static func from(name: String, typeArgument: String? = nil) -> Self? {
        let unsupportedAttributes = ["inline", "rethrows"]
        
        if name.hasPrefix("_") || unsupportedAttributes.contains(name) {
            return nil
        }
        
        if let typeArgument {
            return annotations[name + typeArgument] ?? .customPropertyWrapper
        }
        
        return annotations[name] ?? .customPropertyWrapper
    }
}

fileprivate var annotations: [String: Annotation] = [
    "attached": .attached,
    "available": .available,
    "backDeployed": .backDeployed,
    "discardableResult": .discardableResult,
    "dynamicCallable": .dynamicCallable,
    "dynamicMemberLookup": .dynamicMemberLookup,
    "freestanding": .freestanding,
    "frozen": .frozen,
    "GKInspectable": .gkInspectable,
    "inlinable": .inlinable,
    "main": .main,
    "nonobjc": .nonobjc,
    "NSApplicationMain": .nsApplicationMain,
    "NSCopying": .nsCopying,
    "NSManaged": .nsManaged,
    "objc": .objc,
    "objcMembers": .objcMembers,
    "preconcurrency": .preconcurrency,
    "propertyWrapper": .propertyWrapper,
    "resultBuilder": .resultBuilder,
    "requires_stored_property_inits": .requiresStoredPropertyInits,
    "testable": .testable,
    "UIApplicationMain": .uiApplicationMain,
    "unchecked": .unchecked,
    "usableFromInline": .usableFromInline,
    "warn_unqualified_access": .warnUnqualifiedAccess,
    "customPropertyWrapper": .customPropertyWrapper,
    "autoclosure": .autoclosure,
    "convention(c)": .conventionC,
    "convention(block)": .conventionBlock,
    "convention(swift)": .conventionSwift,
    "escaping": .escaping,
    "Sendable": .sendable,
    "AppStorage": .appStorage,
    "Binding": .binding,
    "Environment": .environment,
    "EnvironmentObject": .environmentObject,
    "FetchRequest": .fetchRequest,
    "FocusedBinding": .focusedBinding,
    "FocusState": .focusState,
    "GestureState": .gestureState,
    "ObservedObject": .observedObject,
    "SceneStorage": .sceneStorage,
    "State": .state,
    "StateObject": .stateObject,
    "Published": .published
]
