//
//  Function.swift
//
//
//  Created by Lucas Cavalcante on 8/26/24.
//

import Foundation

public struct Function: Declaration,
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
    
    public let returnClause: ReturnClause
    
    public let genericClause: String?
    
    public let whereClause: String?
    
    public let body: String?
    
    /// The list of function calls happening in this function, including calls from nested functions or closures.
    ///
    /// Given this function:
    ///
    /// ```swift
    /// func sampleCode() {
    ///     closure {
    ///         functionCall()
    ///     }
    ///
    ///     functionCall()
    /// }
    /// ```
    ///
    /// calling this will return: `["closure", "functionCall", "functionCall"]`.
    public var functionCalls: [String] {
        children.as(FunctionCall.self).map { $0.text }
    }
    
    public func invokes(_ function: String) -> Bool {
        functionCalls.contains(function)
    }
    
    public func invokes(_ predicate: (String) -> Bool) -> Bool {
        functionCalls.contains(where: predicate)
    }
}
