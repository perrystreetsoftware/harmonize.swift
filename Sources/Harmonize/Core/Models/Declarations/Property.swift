import Foundation

public struct Property: Declaration,
                        ModifiersProviding,
                        AttributesProviding {
    public enum DeclarationType: String {
        case `let` = "let"
        case `var` = "var"
        
        static func fromValue(_ value: String) -> DeclarationType {
            if value == DeclarationType.var.rawValue {
                return .var
            }
            
            return .let
        }
    }
    
    public let name: String
    
    public let text: String
    
    public var parent: Declaration?
    
    public var children: [Declaration]
    
    public var modifiers: [Modifier]
    
    public var attributes: [Attribute]
    
    /// If the variable is computed, the accessors that get (and optionally set) the value.
    public let accessors: [Accessor]
    
    /// The underlying type name of this property, such as String, Int, Bool, Array etc.
    public let typeAnnotation: String
    
    /// A flag to identify if the current variable is a constant (let). Otherwise it's a variable (var).
    public let declarationType: DeclarationType
    
    /// The initialization value of the variable, usually an assignment to a value.
    public let initializer: String
    
    /// Returns true if a variable is of an optional type.
    public var isOptional: Bool
    
    /// Returns true if this variable is a top-level declaration which also means it has no parent at all.
    public var isTopLevel: Bool {
        parent == nil
    }
    
    /// Returns true if this variable is a constant.
    public var isImmutable: Bool {
        declarationType == .let
    }
    
    /// Returns true if a symbol is not annotated at all, therefore its type is expected to be inferred by the compiler.
    public var isInferredType: Bool {
        typeAnnotation.isEmpty
    }
}
