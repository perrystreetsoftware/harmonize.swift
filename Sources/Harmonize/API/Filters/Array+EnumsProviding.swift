//
//  Array+EnumsProviding.swift
//  Harmonize
//
//  Created by Lucas Cavalcante on 10/1/24.
//

import Foundation

public extension Array where Element: EnumsProviding {
    func withEnums(_ predicate: (Enum) -> Bool) -> [Element] {
        filter { $0.enums.contains(where: predicate) }
    }
    
    func enums() -> [Enum] {
        flatMap { $0.enums }
    }
}
