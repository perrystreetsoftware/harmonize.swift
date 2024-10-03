//
//  Array+TypeAnnotationProviding.swift
//
//
//  Created by Lucas Cavalcante on 9/17/24.
//

import Foundation

public extension Array where Element: TypeAnnotationProviding {
    func withType(_ predicate: (TypeAnnotation) -> Bool) -> [Element] {
        filter {
            guard let type = $0.typeAnnotation else { return false }
            return predicate(type)
        }
    }
    
    func withType(named: String) -> [Element] {
        withType { $0.annotation == named }
    }
    
    func withType<T>(_ type: T.Type) -> [Element] {
        withType(named: String(describing: type))
    }
    
    func withInferredType() -> [Element] {
        filter { $0.typeAnnotation == nil }
    }
    
    func of<T>(_ type: T.Type) -> [Element] {
        withType(type)
    }
    
    func of(type: String) -> [Element] {
        withType(named: type)
    }
}
