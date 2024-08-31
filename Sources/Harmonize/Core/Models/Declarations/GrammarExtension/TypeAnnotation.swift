import Foundation

public struct TypeAnnotation: Equatable {
    /// Type annotation name of the Swift Type, such as String, Int, Bool or Type (T).
    public let name: String
    
    public let isOptional: Bool
    
    /// Returns true if a symbol is not annotated at all, therefore its type is expected to be inferred by the compiler.
    public var isInferred: Bool {
        name.isEmpty
    }
}
