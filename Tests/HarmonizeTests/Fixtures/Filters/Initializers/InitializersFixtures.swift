//
//  InitializersFixtures.swift
//
//
//  Created by Lucas Cavalcante on 9/17/24.
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
