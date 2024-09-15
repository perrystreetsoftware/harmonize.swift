//
//  AccessorBlockSyntax+AccessorsProviding.swift
//
//
//  Created by Lucas Cavalcante on 9/1/24.
//

import Foundation
import SwiftSyntax

extension Array: AccessorBlocksProviding where Element == AccessorBlockSyntax {
    public var accessorBlocks: [AccessorBlock] {
        flatMap {
            switch $0.accessors {
            case .accessors(let blocks):
                return blocks.compactMap { block -> AccessorBlock? in
                    guard let modifier = AccessorBlock.Modifier.from(identifier: block.accessorSpecifier.text) else { return nil }
                    return AccessorBlock(modifier: modifier, body: block.body?.statements.asString())
                }
            case .getter(let block):
                return [AccessorBlock(modifier: .getter, body: block.asString())]
            }
        }
    }
}
