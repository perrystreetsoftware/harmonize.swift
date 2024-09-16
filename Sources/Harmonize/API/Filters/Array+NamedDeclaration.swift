//
//  Array+NamedDeclaration.swift
//
//
//  Created by Lucas Cavalcante on 9/14/24.
//

import Foundation

extension Array where Element: NamedDeclaration {
    public func withSuffix(_ suffixes: String...) -> [Element] {
        filter { declaration in
            suffixes.contains { suffix in
                declaration.name.hasSuffix(suffix)
            }
        }
    }
    
    public func withoutSuffix(_ suffixes: String...) -> [Element] {
        filter { declaration in
            !suffixes.contains { suffix in
                declaration.name.hasSuffix(suffix)
            }
        }
    }
    
    public func withPrefix(_ prefixes: String...) -> [Element] {
        filter { declaration in
            prefixes.contains { prefix in
                declaration.name.hasPrefix(prefix)
            }
        }
    }
    
    public func withoutPrefix(_ prefixes: String...) -> [Element] {
        filter { declaration in
            !prefixes.contains { prefix in
                declaration.name.hasPrefix(prefix)
            }
        }
    }
    
    public func withNameContaining(_ parts: String...) -> [Element] {
        filter { declaration in
            parts.contains { part in
                declaration.name.contains(part)
            }
        }
    }
    
    public func withoutNameContaining(_ parts: String...) -> [Element] {
        filter { declaration in
            !parts.contains { part in
                declaration.name.contains(part)
            }
        }
    }
}
