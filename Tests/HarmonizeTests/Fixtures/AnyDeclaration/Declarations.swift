//
//  Declarations.swift
//
//
//  Created by Lucas Cavalcante on 8/18/24.
//

import Foundation

protocol Loggable {
    func log()
}

protocol Debugging {
    func log()
}

protocol Warning {
    func log()
}

class LoggableImpl: Loggable {
    protocol Loggable {
        func didLog()
    }
    
    class Rewriter {}
    
    public var property: String?, name: String?
    
    func log() {
        func run() {}
    }
}
