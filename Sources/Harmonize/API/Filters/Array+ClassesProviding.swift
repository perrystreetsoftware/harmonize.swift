//
//  Array+ClassesProviding.swift
//  Harmonize
//
//  Created by Lucas Cavalcante on 10/1/24.
//

import Foundation

public extension Array where Element: ClassesProviding {
    func withClasses(_ predicate: (Class) -> Bool) -> [Element] {
        filter { $0.classes.contains(where: predicate) }
    }
    
    func classes() -> [Class] {
        flatMap { $0.classes }
    }
}
