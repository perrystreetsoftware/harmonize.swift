//
//  Array+InheritanceProviding.swift
//
//
//  Created by Lucas Cavalcante on 9/16/24.
//

import Foundation

public extension Array where Element: InheritanceProviding {
    func inheriting(_ anyClass: AnyObject.Type) -> [Element] {
        inheriting(name: String(describing: anyClass.self))
    }
    
    func inheriting(name: String) -> [Element] {
        filterByInheritanceTypes(names: [name])
    }
    
    func conforming<T>(_ type: T.Type) -> [Element] {
        conforming(names: String(describing: type.self))
    }
    
    func conforming(names: String...) -> [Element] {
        filterByInheritanceTypes(names: names)
    }
    
    private func filterByInheritanceTypes(names: [String]) -> [Element] {
        filter { element in
            names.contains { name in
                element.inheritanceTypesNames.contains(name)
            }
        }
    }
}
