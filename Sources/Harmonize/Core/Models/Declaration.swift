import Foundation

public protocol Declaration {
    /// The actual name of the declaration.
    var name: String { get }
    
    /// The raw text content of the declaration.
    var text: String { get }
    
    var parent: Declaration? { get set }
    
    var children: [Declaration] { get set }
}
