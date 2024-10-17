//
//  AccessorsBlocksFixtures.swift
//
//
//  Copyright (c) Perry Street Software 2024. All Rights Reserved.
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
