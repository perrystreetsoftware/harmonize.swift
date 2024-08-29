//
//  HarmonizeUtils.swift
//
//
//  Created by Lucas Cavalcante on 8/19/24.
//

import Foundation
import Harmonize

public class HarmonizeUtils {
    private var projectRoot: URL
    
    public init() {
        let thisFile = URL(fileURLWithPath: #file)
        let projectRoot = thisFile
          .deletingLastPathComponent()
          .appending(path: "CodeSample")
        
        self.projectRoot = projectRoot
    }
    
    public func appendingPath(_ path: String) -> HarmonizeUtils {
        projectRoot = projectRoot.appending(path: path)
        return self
    }
    
    public func harmonize() -> Harmonize {
        Harmonize(projectPath: projectRoot)
    }
}
