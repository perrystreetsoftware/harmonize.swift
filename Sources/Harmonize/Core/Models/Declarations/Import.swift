//
//  Import.swift
//
//
//  Created by Lucas Cavalcante on 9/5/24.
//

import Foundation

public struct Import: Declaration,
                      NamedDeclaration,
                      FileSourceProviding,
                      AttributesProviding {
    public var text: String
    
    public var name: String
    
    public var kind: ImportKind
    
    public var swiftFile: SwiftFile
    
    public var attributes: [Attribute]
}
