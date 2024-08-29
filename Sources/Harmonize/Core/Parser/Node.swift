import Foundation

/// The root source code for visited declarations
/// Based on Hatch's Scope
indirect enum Node {
    case root(declarations: [SwiftDeclaration])
    case nested(node: Node, declarations: [SwiftDeclaration])
    
    var declarations: [SwiftDeclaration] {
        switch self {
        case let .root(declarations):
            declarations
        case let .nested(_, declarations):
            declarations
        }
    }
}
