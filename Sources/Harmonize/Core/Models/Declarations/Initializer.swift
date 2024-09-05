//
//  Initializer.swift
//
//
//  Created by Lucas Cavalcante on 8/28/24.
//

import Foundation

public protocol Initializer: Declaration,
                             ParentDeclarationProviding,
                             ChildrenDeclarationProviding,
                             BodyProviding,
                             ModifiersProviding,
                             AttributesProviding,
                             ParametersProviding,
                             InitializersProviding,
                             FunctionsProviding,
                             PropertiesProviding {}
