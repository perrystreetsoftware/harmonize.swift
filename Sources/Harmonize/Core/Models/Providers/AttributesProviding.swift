//
//  AttributesProviding.swift
//
//
//  Created by Lucas Cavalcante on 8/23/24.
//

import Foundation

public protocol AttributesProviding {
    /// All attributes this declaration has.
    var attributes: [Attribute] { get }
}
