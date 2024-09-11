//
//  Harmonize.swift
//  
//
//  Created by Lucas Cavalcante on 9/7/24.
//

import Foundation

public struct Harmonize {    
    private init() {}
    
    public static func productionAndTestCode() -> Builder {
        Harmonizer()
    }
    
    public static func productionCode() -> Builder {
        Harmonizer(exclusions: ["Tests", "Fixtures"])
    }
    
    public static func testCode() -> Builder {
        Harmonizer(includingOnly: ["Tests", "Fixtures"])
    }
}
