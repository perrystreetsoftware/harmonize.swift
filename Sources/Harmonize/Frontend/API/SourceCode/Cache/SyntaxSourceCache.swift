//
//  SyntaxSourceCache.swift
//  Harmonize
//
//  Copyright (c) Perry Street Software 2024. All Rights Reserved.
//

import Foundation
import SwiftSyntax
import SwiftParser
import HarmonizeUtils

internal class SyntaxSourceCache<Syntax: SyntaxProtocol> {
    private var elements: ConcurrentDictionary<UUID, Syntax> = ConcurrentDictionary()
    private let factory: (SwiftSourceCode) -> Syntax
    
    init(factory: @escaping (SwiftSourceCode) -> Syntax) {
        self.factory = factory
    }
    
    func get(_ source: SwiftSourceCode) -> Syntax {
        guard let element = elements[source.id] else {
            let newElement = factory(source)
            elements[source.id] = newElement
            return newElement
        }
        
        return element
    }
    
    func set(_ source: SwiftSourceCode, value: Syntax) {
        elements[source.id] = value
    }
    
    func removeValue(forKey uuid: UUID) -> Syntax? {
        elements.removeValue(forKey: uuid)
    }
    
    func removeAll() {
        elements.removeAll()
    }
}

internal let cachedSyntaxTree = SyntaxSourceCache {
    Parser.parse(source: $0.source)
}
