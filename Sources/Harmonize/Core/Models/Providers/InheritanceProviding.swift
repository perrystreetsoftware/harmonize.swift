import Foundation

public protocol InheritanceProviding {
    /// All names of the types this declaration inherits from or conforms to.
    var inheritanceTypesNames: [String] { get }
}

public extension InheritanceProviding {
    /// Returns if the declaration inherits from the given any object type.
    func inherits(from type: AnyObject.Type) -> Bool {
        inherits(from: String(describing: type.self))
    }
    
    /// Returns if the declarations inheris from the given object name.
    func inherits(from name: String) -> Bool {
        inheritanceTypesNames.contains(name)
    }
    
    /// Returns if the declarations conforms to the given protocol.
    func conforms<T>(to type: T.Type) -> Bool {
        inheritanceTypesNames.contains(String(describing: type.self))
    }
    
    /// Returns if the declarations conforms to the given protocol.
    func conforms(to protos: String...) -> Bool {
        inheritanceTypesNames.contains(protos)
    }
    
    /// Returns if the declarations conforms to the given protocol.
    func conforms(to protos: [String]) -> Bool {
        inheritanceTypesNames.contains(protos)
    }
}
