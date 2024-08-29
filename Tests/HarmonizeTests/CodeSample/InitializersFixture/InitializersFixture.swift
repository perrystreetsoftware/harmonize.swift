//
//  File.swift
//  
//
//  Created by Lucas Cavalcante on 8/29/24.
//

import Foundation

protocol Proto {
    init(param1: String, param2: String)
}

class InitializableProgram: Proto {
    required init(param1: String, param2: String) {
        print("\(param1) - \(param2)")
    }
    
    @objc init() {
        func hold() {}
        
        execute()
    }
    
    private func execute() {
        // run...
    }
}

struct Structure {
    var property: String
    
    init(property: String) {
        self.property = property
    }
    
    dynamic init(property: String, value: Int) {
        self.property = property
    }
}
