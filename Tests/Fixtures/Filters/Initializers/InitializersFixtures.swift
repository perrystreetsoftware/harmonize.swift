//
//  InitializersFixtures.swift
//
//
//  Copyright (c) Perry Street Software 2024. All Rights Reserved.
//

import Foundation

struct MyInitializer {
    let param: String
    
    init() {
        self.param = "42"
    }
    
    init(param: String) {
        self.param = param
    }
}

extension MyInitializer {
    init(intParam: Int) {
        self.param = String(intParam)
    }
}
