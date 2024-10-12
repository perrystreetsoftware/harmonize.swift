//
//  SyntaxProtocol+ResolveParent.swift
//  Harmonize
//
//  Copyright (c) Perry Street Software 2024. All Rights Reserved.
//

import SwiftSyntax

internal extension SyntaxProtocol {
    /// Recursively searches for the first parent of the given type `T`.
    /// - Parameter type: The type of the parent to search for.
    /// - Returns: The parent of type `T` if found, otherwise `nil`.
    func parentAs<T: SyntaxProtocol>(_ type: T.Type) -> T? {
        var currentParent = self.parent
        
        while let parent = currentParent {
            if let matchedParent = parent as? T {
                return matchedParent
            }
            
            currentParent = parent.parent
        }
        
        return nil
    }
}
