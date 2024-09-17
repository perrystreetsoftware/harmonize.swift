//
//  Array+InitializerClauseProviding.swift
//
//
//  Created by Lucas Cavalcante on 9/17/24.
//

import Foundation

public extension Array where Element: InitializerClauseProviding {
    func withInitializerClause(_ predicate: (InitializerClause) -> Bool) -> [Element] {
        filter {
            guard let initializerClause = $0.initializerClause
            else { return false }
            
            return predicate(initializerClause)
        }
    }
}
