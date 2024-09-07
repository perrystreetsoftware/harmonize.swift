//
//  TestUtils.swift
//
//
//  Created by Lucas Cavalcante on 8/19/24.
//

import Foundation
@testable import Harmonize

class TestUtils {
    private init() {}
    
    static func harmonize(atFixtures fixturePath: String) -> Harmonize {
        let projectPath = try! URLResolver.resolveProjectRootPath()
            .appendingPathComponent("Tests/HarmonizeTests/Fixtures/\(fixturePath)")
        
        return Harmonize(projectPath: projectPath)
    }
    
    static func harmonize() -> Harmonize {
        Harmonize(projectPath: try! URLResolver.resolveProjectRootPath())
    }
}
