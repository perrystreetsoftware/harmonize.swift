//
//  ModifiersProviding.swift
//
//
//  Created by Lucas Cavalcante on 8/23/24.
//

import Foundation

public protocol ModifiersProviding {
    /// An array of all modifiers the declaration is annotated with, such as `public`, `fileprivate` etc.
    var modifiers: [SwiftModifier] { get }
}
