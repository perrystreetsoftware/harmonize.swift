import Foundation

public protocol InheritanceProviding {
    /// All names of the types this declaration inherits from or conforms to.
    var inheritanceTypesNames: [String] { get }
}
