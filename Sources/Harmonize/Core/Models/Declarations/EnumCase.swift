//
//  EnumCase.swift
//
//
//  Created by Lucas Cavalcante on 9/5/24.
//

import Foundation

public struct EnumCase: Declaration,
                        NamedDeclaration,
                        ParentDeclarationProviding,
                        AttributesProviding,
                        ModifiersProviding,
                        InitializerClauseProviding {
    public var name: String
    
    public var text: String
    
    public var parent: Declaration?
            
    public var attributes: [Attribute]
    
    public var modifiers: [Modifier]
    
    public var initializerClause: InitializerClause?
    
    public var parameters: [EnumCaseParameter]
}
