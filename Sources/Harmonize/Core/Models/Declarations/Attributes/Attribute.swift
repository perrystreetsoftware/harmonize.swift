//
//  Attribute.
//
//
//  Created by Lucas Cavalcante on 8/24/24.
//

import Foundation

public enum Attribute: Equatable {
    // TODO: to make arguments to be typed in a future release.
    case declaration(attribute: DeclarationAttribute, arguments: [String])
    case type(attribute: TypeAttribute)
    case customPropertyWrapper(name: String, arguments: [String])
    
    public static func from(attributeName: String, arguments: [String] = []) -> Attribute? {
        let name = "@\(attributeName)"
        
        func isAttributeUnsupported() -> Bool {
            // we don't support undescore attributes for this initial release.
            attributeName.hasPrefix("_") || unsupportedAttributes.contains(name)
        }
        
        if isAttributeUnsupported() {
            return nil
        }
        
        if let declaration = DeclarationAttribute.from(name: name) {
            return .declaration(attribute: declaration, arguments: arguments)
        }
        
        let typeArgument = arguments.first ?? ""
        
        if let type = TypeAttribute.from(name: name + typeArgument) {
            return .type(attribute: type)
        }
        
        return .customPropertyWrapper(name: attributeName, arguments: arguments)
    }
    
    private static var unsupportedAttributes = ["@inline", "@rethrows"]
}
