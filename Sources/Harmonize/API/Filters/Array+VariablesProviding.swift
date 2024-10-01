//
//  Array+VariablesProviding.swift
//
//
//  Created by Lucas Cavalcante on 9/17/24.
//

import Foundation

public extension Array where Element: VariablesProviding {
    func withVariables(_ predicate: (Variable) -> Bool) -> [Element] {
        filter { $0.variables.contains(where: predicate) }
    }
    
    func variables() -> [Variable] {
        flatMap { $0.variables }
    }
}
