//
//  Array+FunctionsProviding.swift
//
//
//  Created by Lucas Cavalcante on 9/17/24.
//

import Foundation

public extension Array where Element: FunctionsProviding {
    func withFunctions(_ predicate: (Function) -> Bool) -> [Element] {
        filter { $0.functions.contains(where: predicate) }
    }
    
    func functions() -> [Function] {
        flatMap { $0.functions }
    }
}
