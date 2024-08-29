import Foundation

public struct SwiftInitializerClause: Equatable {
    /// The value of the initializer clause, representing the content assigned after the `=` sign.
    ///
    /// For example, in the declaration `var prop = "xyz"`, the `value` is `"xyz"`.
    public let value: String
}
