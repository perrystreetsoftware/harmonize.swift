//
//  File.swift
//  
//
//  Created by Lucas Cavalcante on 8/18/24.
//

import Foundation

protocol MyProtocol {
    var property: String { get }
}

@requires_stored_property_inits
@objc
class MyFile: NSObject, MyProtocol, @unchecked Sendable {
    var property: String = "x"
    let y: Int = 0
    
    class StateSample {
        
    }
    
    func main() {
        print("sample code")
    }
}

class MyClass2: MyProtocol {
    var property: String = "y"
    
    func first() {
        var _ = 42
    }
    
    func second() {
        var _ = 44
    }
}
