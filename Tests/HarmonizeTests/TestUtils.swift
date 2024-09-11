//
//  TestUtils.swift
//
//
//  Created by Lucas Cavalcante on 8/19/24.
//

import Foundation
import Harmonize

class TestUtils {
    private init() {}
    
    static func harmonize(at folder: String) -> HarmonizeScope {
        Harmonize.productionCode().on("Tests/HarmonizeTests/\(folder)")
    }
}
