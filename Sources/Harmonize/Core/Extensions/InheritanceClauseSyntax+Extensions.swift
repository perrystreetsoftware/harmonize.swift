import Foundation
import SwiftSyntax

extension InheritanceClauseSyntax {
    func typesAsString() -> [String] {
        inheritedTypes.compactMap {
            if let attributedType = $0.type.as(AttributedTypeSyntax.self) {
                return attributedType.baseType.trimmedDescription
            }
            
            return $0.type.trimmedDescription
        }
    }
}
