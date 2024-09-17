//
//  Array+AttributesProviding.swift
//
//
//  Created by Lucas Cavalcante on 9/16/24.
//

import Foundation

public extension Array where Element: AttributesProviding {
    func withAttribute(_ predicate: (Attribute) -> Bool) -> [Element] {
        filter {
            $0.attributes.contains(where: predicate)
        }
    }
    
    func withAttribute(named: String) -> [Element] {
        let name = named.contains("@") ? named : "@\(named)"
        
        return withAttribute { $0.name == name }
    }
    
    func withAttribute(annotation: Annotation) -> [Element] {
        withAttribute { $0.annotation == annotation }
    }
    
    /// Filters the array to include only elements whose attributes contains a given property wrapper.
    ///
    /// In cases where the property wrapper has a generic constraint, this function will ignore it.
    /// e.g: `Published<Int>.self` will fallback to `@Published`
    ///
    /// - Parameter type: the property wrapper type the elements should be attributed with.
    /// - Returns: elements attributed with the given property wrapper.
    func withPropertyWrapper<T>(_ type: T.Type) -> [Element] {
        let regexMatchingTypeValue = #/<[^>]+>/#
        let typeName = String(describing: type).replacing(regexMatchingTypeValue, with: "")
        return withAttribute { $0.name == "@\(typeName)"}
    }
}
