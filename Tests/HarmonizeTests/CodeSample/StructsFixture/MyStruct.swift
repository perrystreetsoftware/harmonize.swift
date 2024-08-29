//
//  File.swift
//  
//
//  Created by Lucas Cavalcante on 8/19/24.
//

import Foundation

public struct MyStruct {
    public protocol MyStructProtocol {}
    
    public struct MyStructItem: MyStructProtocol {
        public let prop1: String
        public let prop2: String
    }
    
    public let property1: String
    public let property2: Int
    public let property3: Bool
    public let items: [MyStructItem]
    
    public func someFunction() -> Int { property2 + 2 }
}

@dynamicCallable
public struct AttributedStruct {
    func dynamicallyCall(withArguments args: [Int]) -> Int {
        return args.reduce(0, +)
    }
}
