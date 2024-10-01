//
//  Array+ParametersProviding.swift
//
//
//  Created by Lucas Cavalcante on 9/17/24.
//

import Foundation

public extension Array where Element: ParametersProviding {
    func withParameters(_ predicate: (Parameter) -> Bool) -> [Element] {
        filter { $0.parameters.contains(where: predicate) }
    }
    
    func parameters() -> [Parameter] {
        flatMap { $0.parameters }
    }
}
