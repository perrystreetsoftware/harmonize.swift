//
//  ImportKind.swift
//
//
//  Created by Lucas Cavalcante on 9/5/24.
//

import Foundation

public enum ImportKind: String {
    case none
    case `typealias`, `struct`, `class`, `enum`, `protocol`, `let`, `var`, `func`
}
