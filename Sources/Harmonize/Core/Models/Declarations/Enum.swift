//
//  Enum.swift
//
//
//  Created by Lucas Cavalcante on 9/5/24.
//

import Foundation

public protocol Enum: Declaration,
                      NamedDeclaration,
                      ParentDeclarationProviding,
                      ChildrenDeclarationProviding,
                      FileSourceProviding,
                      InheritanceProviding,
                      AttributesProviding,
                      ModifiersProviding,
                      PropertiesProviding,
                      FunctionsProviding {
    // A collection of all declared cases of this enum.
    var cases: [EnumCase] { get }
}
