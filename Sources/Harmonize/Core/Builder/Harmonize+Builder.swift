//
//  Harmonize+Builder.swift
//  
//
//  Created by Lucas Cavalcante on 9/10/24.
//

import Foundation

extension Harmonize {
    public protocol OnFolderBuilder: HarmonizeScope {
        func on(_ folder: String) -> FolderFilteringBuilder
    }
    
    public protocol FolderFilteringBuilder: HarmonizeScope {
        func excluding(_ excludes: String...) -> HarmonizeScope
    }
    
    public protocol Builder: OnFolderBuilder, FolderFilteringBuilder {}
}
