//
//  Array+Declaration.swift
//
//
//  Created by Lucas Cavalcante on 9/17/24.
//

import Foundation

public extension Array where Element: Declaration {
    func withText(_ predicate: (String) -> Bool) -> [Element] {
        filter { predicate($0.text) }
    }
    
    func withoutText(_ predicate: (String) -> Bool) -> [Element] {
        filter { !predicate($0.text) }
    }
}
