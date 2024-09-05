import Foundation

/// Represents the name of an identifier.
///
/// For example, in the declaration `let file: String`, the identifier name is `"file"`.
public struct Identifier: Equatable {
    /// The name of the identifier.
    public let name: String
    
    public init(name: String) {
        self.name = name
    }
}
