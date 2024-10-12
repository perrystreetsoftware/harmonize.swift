//
//  DeclModifierListSyntax+ModifiersProviding.swift
//  Harmonize
//
//  Copyright (c) Perry Street Software 2024. All Rights Reserved.
//

import SwiftSyntax

extension DeclModifierListSyntax: ModifiersProviding {
    public var modifiers: [Modifier] {
        Modifier.modifiers(from: self)
    }
}
