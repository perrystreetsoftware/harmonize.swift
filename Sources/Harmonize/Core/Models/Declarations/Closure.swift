//
//  Closure.swift
//  Harmonize
//
//  Created by Lucas Cavalcante on 10/1/24.
//

public struct Closure: Declaration,
                        NamedDeclaration,
                        ParentDeclarationProviding,
                        ChildDeclarationsProviding,
                        ClassesProviding,
                        ProtocolsProviding,
                        EnumsProviding,
                        StructsProviding,
                        FileSourceProviding,
                        BodyProviding,
                        ParametersProviding,
                        ModifiersProviding,
                        FunctionsProviding {
    public var name: String
    
    public var text: String
    
    public var parent: Declaration? = nil
    
    public var children: [Declaration] = []
    
    public var swiftFile: SwiftFile
    
    public var modifiers: [Modifier]
    
    public var classes: [Class] {
        children.as(Class.self)
    }
    
    public var enums: [Enum] {
        children.as(Enum.self)
    }
    
    public var structs: [Struct] {
        children.as(Struct.self)
    }
    
    public var protocols: [ProtocolDeclaration] {
        children.as(ProtocolDeclaration.self)
    }
    
    public var functions: [Function] {
        children.as(Function.self)
    }
    
    public var parameters: [Parameter] {
        children.as(Parameter.self)
    }
    
    public let body: String?
    
    /// All others functions reference this function's body invokes.
    public let functionCalls: [String]
    
    public func invokes(_ function: String) -> Bool {
        functionCalls.contains(function)
    }
}
