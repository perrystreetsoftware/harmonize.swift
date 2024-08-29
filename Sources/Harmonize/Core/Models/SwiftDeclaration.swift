import Foundation

public protocol SwiftDeclaration {
    /// The actual name of the declaration.
    var name: String { get }
    
    /// The raw text content of the declaration.
    var text: String { get }
    
    var parent: SwiftDeclaration? { get set }
    
    var children: [SwiftDeclaration] { get set }
}
