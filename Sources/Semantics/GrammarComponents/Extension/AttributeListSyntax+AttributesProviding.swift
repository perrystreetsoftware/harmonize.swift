//
//  AttributeListSyntax+AttributesProviding.swift
//  Harmonize
//
//  Copyright (c) Perry Street Software 2024. All Rights Reserved.
//

import SwiftSyntax

extension AttributeListSyntax: AttributesProviding {
    public var attributes: [Attribute] {
        Attribute.attributes(from: self)
    }
}
