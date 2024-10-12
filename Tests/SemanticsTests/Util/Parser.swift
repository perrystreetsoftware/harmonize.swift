//
//  Parser.swift
//  Harmonize
//
//  Copyright (c) Perry Street Software 2024. All Rights Reserved.
//

import SwiftSyntax
import SwiftParser

extension String {
    func parsed() -> SourceFileSyntax {
        Parser.parse(source: self)
    }
}
