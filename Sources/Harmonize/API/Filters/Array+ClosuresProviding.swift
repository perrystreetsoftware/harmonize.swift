//
//  Array+ClosuresProviding.swift
//  Harmonize
//
//  Created by Lucas Cavalcante on 10/1/24.
//

import Foundation

public extension Array where Element: ClosuresProviding {
    func withClosures(_ predicate: (Closure) -> Bool) -> [Element] {
        filter { $0.closures.contains(where: predicate) }
    }
    
    func closures() -> [Closure] {
        flatMap { $0.closures }
    }
}
