//
//  File.swift
//  
//
//  Created by Stelios Frantzeskakis on 23/8/24.
//

import Foundation

protocol DataRepresentable {
    var property: String { get }
    func someMethod()
}

@objc protocol Configurable {
    @objc optional func optionalMethod()
}

protocol NetworkRequestable: Configurable {
    func someMethod()
}

protocol ClassOnlyProtocol: AnyObject {
    func someMethod()
}

class NestedProtocolInClass {
    protocol NamedDelegate {
        var name: String { get set }
    }
}

struct NestedProtocolInStruct {
    protocol NamedDelegate {
        var name: String { get set }
    }
}

@rethrows // unsupported
@objc
protocol Throwable {
    
}
