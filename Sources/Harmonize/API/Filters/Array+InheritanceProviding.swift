//
//  Array+InheritanceProviding.swift
//
//
//  Created by Lucas Cavalcante on 9/16/24.
//

import Foundation

public extension Array where Element: InheritanceProviding {
    func withInheritanceType(_ predicate: (String) -> Bool) -> [Element] {
        filter { $0.inheritanceTypesNames.contains(where: predicate) }
    }
    
    func inheriting(_ anyClass: AnyObject.Type) -> [Element] {
        inheriting(name: String(describing: anyClass.self))
    }
    
    func inheriting(name: String) -> [Element] {
        withInheritanceType { $0 == name }
    }
    
    func conforming<T>(_ type: T.Type) -> [Element] {
        conforming(names: String(describing: type.self))
    }
    
    func conforming(names: String...) -> [Element] {
        withInheritanceType { names.contains($0) }
    }
}
