//
//  Array+BodyProviding.swift
//
//
//  Created by Lucas Cavalcante on 9/17/24.
//

import Foundation

public extension Array where Element: BodyProviding {
    func withBody(_ predicate: (String) -> Bool) -> [Element] {
        filter {
            guard let body = $0.body else { return false }
            return predicate(body)
        }
    }
    
    func withBody(containing regex: some RegexComponent) -> [Element] {
        withBody { $0.contains(regex) }
    }
    
    func withoutBody(_ predicate: (String) -> Bool) -> [Element] {
        filter {
            guard let body = $0.body else { return false }
            return !predicate(body)
        }
    }
}
