//
//  TypeAnnotation+Equatable.swift
//
//
//  Created by Lucas Cavalcante on 9/17/24.
//

import Foundation

public extension TypeAnnotation {
    static func == <T>(lhs: TypeAnnotation, rhs: T.Type) -> Bool {
        return lhs.annotation == String(describing: rhs.self)
    }
}
