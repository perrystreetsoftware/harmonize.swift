import Foundation

/// The root source code for visited declarations
/// Based on Hatch's Scope
indirect enum Node {
    case root(declarations: [Declaration])
    case nested(node: Node, declarations: [Declaration])
    
    var declarations: [Declaration] {
        switch self {
        case let .root(declarations):
            declarations
        case let .nested(_, declarations):
            declarations
        }
    }
}
