//
//  Array+ClassesProviding.swift
//  Harmonize
//
//  Created by Lucas Cavalcante on 10/1/24.
//

import Foundation

public extension Array where Element: ProtocolsProviding {
    func withProtocols(_ predicate: (ProtocolDeclaration) -> Bool) -> [Element] {
        filter { $0.protocols.contains(where: predicate) }
    }
    
    func protocols() -> [ProtocolDeclaration] {
        flatMap { $0.protocols }
    }
}
