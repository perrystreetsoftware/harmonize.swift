import Foundation

public protocol PropertiesProviding {
    /// All properties on the declaration.
    var properties: [SwiftProperty] { get }
}
