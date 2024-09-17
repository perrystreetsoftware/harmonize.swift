//
//  Array+ModifiersProviding.swift
//
//
//  Created by Lucas Cavalcante on 9/17/24.
//

import Foundation

public extension Array where Element: ModifiersProviding {
    func withModifiers(_ predicate: (Modifier) -> Bool) -> [Element] {
        filter { $0.modifiers.contains(where: predicate) }
    }
    
    func withoutModifiers(_ predicate: (Modifier) -> Bool) -> [Element] {
        filter { !$0.modifiers.contains(where: predicate) }
    }
    
    func withModifier(_ modifiers: Modifier...) -> [Element] {
        withModifiers { modifiers.contains($0) }
    }
    
    func withoutModifier(_ modifiers: Modifier...) -> [Element] {
        withoutModifiers { modifiers.contains($0) }
    }
    
    func withPublicModifier() -> [Element] {
        withModifier(.public)
    }
    
    func withPrivateModifier() -> [Element] {
        withModifier(.private)
    }
    
    func withFinalModifier() -> [Element] {
        withModifier(.final)
    }
}
