//
//  Array+InheritanceProviding.swift
//
//
//  Created by Lucas Cavalcante on 9/16/24.
//

import Foundation

public extension Array where Element: InheritanceProviding {
    func inheriting(_ anyClass: AnyObject.Type) -> [Element] {
        filter { $0.inherits(from: anyClass) }
    }
    
    func inheriting(from name: String) -> [Element] {
        filter { $0.inherits(from: name) }
    }
    
    func conforming<T>(to proto: T.Type) -> [Element] {
        filter { $0.conforms(to: proto) }
    }
    
    func conforming(to names: String...) -> [Element] {
        filter { $0.conforms(to: names) }
    }
    
    func conforming(to names: [String]) -> [Element] {
        filter { $0.conforms(to: names) }
    }
}
