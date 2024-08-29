//
//  SwiftReturnClause.swift
//
//
//  Created by Lucas Cavalcante on 8/26/24.
//

import Foundation

public enum SwiftReturnClause: Equatable {
    case absent
    case type(String)
    
    static func from(_ value: String?) -> SwiftReturnClause {
        guard let value = value else { return .absent }
        return .type(value)
    }
}
