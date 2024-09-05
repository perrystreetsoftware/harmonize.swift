import Foundation

public struct TypeAnnotation: Equatable {
    /// Type annotation name of the Swift Type, such as String, Int, Bool or Type (T).
    public let name: String
    
    public let isOptional: Bool
    
    public init(name: String, isOptional: Bool) {
        self.name = name
        self.isOptional = isOptional
    }
}
