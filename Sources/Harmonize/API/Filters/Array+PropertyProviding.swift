//
//  Array+PropertyProviding.swift
//
//
//  Created by Lucas Cavalcante on 9/17/24.
//

import Foundation

public extension Array where Element: PropertiesProviding {
    func withProperties(_ predicate: (Property) -> Bool) -> [Element] {
        filter { $0.properties.contains(where: predicate) }
    }
}
