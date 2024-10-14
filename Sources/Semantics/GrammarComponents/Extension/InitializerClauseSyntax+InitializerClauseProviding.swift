//
//  InitializerClauseSyntax+InitializerClauseProviding.swift
//  Harmonize
//
//  Copyright (c) Perry Street Software 2024. All Rights Reserved.
//

import Foundation
import SwiftSyntax

extension InitializerClauseSyntax: InitializerClauseProviding {
    public var initializerClause: InitializerClause? {
        InitializerClause(node: self)
    }
}
