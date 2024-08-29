import Foundation

/// Represents the name of an identifier.
///
/// For example, in the declaration `let file: String`, the identifier name is `"file"`.
public struct SwiftIdentifier: Equatable {
    /// The name of the identifier.
    public let name: String
}
