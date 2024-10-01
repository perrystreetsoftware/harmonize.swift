//
//  Array+EnumsProviding.swift
//  Harmonize
//
//  Created by Lucas Cavalcante on 10/1/24.
//

import Foundation

public extension Array where Element == Enum {
    func withCases(_ predicate: (EnumCase) -> Bool) -> [Element] {
        filter { $0.cases.contains(where: predicate) }
    }
    
    func cases() -> [EnumCase] {
        flatMap { $0.cases }
    }
}
