//
//  enums.swift
//
//
//  Created by Lucas Cavalcante on 9/5/24.
//

import Foundation

public enum Role: Equatable {
    @usableFromInline
    enum Merch: String {
        case svet = "svet"
        case esac = "esac"
    }
    
    case noop(String)
    case pump(_ firstName: String)
    
    private func merch() -> Merch {
        switch self {
        case .noop(_):
                .esac
        case .pump(_):
                .svet
        }
    }
    
    static func from(value: String) -> Self {
        .pump(value)
    }
    
    var label: String {
        switch self {
        case .noop(let string):
            string
        case .pump(let labelString):
            labelString
        }
    }
}

public enum Order: String {
    case a, b, c, d = "Di", e, f, g
}
