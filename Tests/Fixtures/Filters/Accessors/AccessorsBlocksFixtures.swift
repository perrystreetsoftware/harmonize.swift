//
//  AccessorsBlocksFixtures.swift
//
//
//  Created by Lucas Cavalcante on 9/17/24.
//

import Foundation

var variable: String {
    "that's a getter"
}

var pointed: String = "Test" {
    willSet { _ = "willset" }
    didSet { _ = "didset" }
}

var variable2: String {
    get {
        "that's a get"
    }
    
    set {
        _ = "that's the new value: \(newValue)"
    }
}
