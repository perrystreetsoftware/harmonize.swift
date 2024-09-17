//
//  Array+AccessorBlocksProviding.swift
//
//
//  Created by Lucas Cavalcante on 9/17/24.
//

import Foundation

public extension Array where Element: AccessorBlocksProviding {
    func withAccessorBlocks(_ predicate: (AccessorBlock) -> Bool) -> [Element] {
        filter { $0.accessorBlocks.contains(where: predicate) }
    }
    
    func withAcessorBlockBody(
        _ accessorModifier: AccessorBlock.Modifier,
        predicate: (String?) -> Bool
    ) -> [Element] {
        withAccessorBlocks {
            return if $0.modifier == accessorModifier {
                predicate($0.body)
            } else { false }
        }
    }
    
    func withAcessorBlockBody(_ accessorModifier: AccessorBlock.Modifier) -> [Element] {
        withAccessorBlocks { $0.modifier == accessorModifier }
    }
    
    func withGetter(_ predicate: (String?) -> Bool) -> [Element] {
        withAcessorBlockBody(.getter, predicate: predicate)
    }
    
    func withGet(_ predicate: (String?) -> Bool) -> [Element] {
        withAcessorBlockBody(.get, predicate: predicate)
    }
    
    func withSet(_ predicate: (String?) -> Bool) -> [Element] {
        withAcessorBlockBody(.set, predicate: predicate)
    }
    
    func withDidSet(_ predicate: (String?) -> Bool) -> [Element] {
        withAcessorBlockBody(.didSet, predicate: predicate)
    }
    
    func withWillSet(_ predicate: (String?) -> Bool) -> [Element] {
        withAcessorBlockBody(.willSet, predicate: predicate)
    }
}
