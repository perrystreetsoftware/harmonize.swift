//
//  Array+InitializersProviding.swift
//
//
//  Created by Lucas Cavalcante on 9/17/24.
//

import Foundation

public extension Array where Element: InitializersProviding {
    func withInitializers(_ predicate: (Initializer) -> Bool) -> [Element] {
        filter { $0.initializers.contains(where: predicate) }
    }
}
