//
//  String+Operators.swift
//  Harmonize
//
//  Created by Lucas Cavalcante on 10/2/24.
//

public extension String {
    static func ||(lhs: String, rhs: String) -> [String] {
        [lhs, rhs]
    }
}

public extension Array where Element == String {
    static func ||(lhs: [String], rhs: String) -> [String] {
        lhs + [rhs]
    }
}
