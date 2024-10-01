//
//  Array+ClassesProviding.swift
//  Harmonize
//
//  Created by Lucas Cavalcante on 10/1/24.
//

import Foundation

public extension Array where Element: StructsProviding {
    func withStructs(_ predicate: (Struct) -> Bool) -> [Element] {
        filter { $0.structs.contains(where: predicate) }
    }
    
    func structs() -> [Struct] {
        flatMap { $0.structs }
    }
}
