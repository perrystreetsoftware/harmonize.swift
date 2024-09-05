import Foundation

public protocol Class: Declaration,
                       NamedDeclaration,
                       ParentDeclarationProviding,
                       ChildrenDeclarationProviding,
                       FileSourceProviding,
                       InheritanceProviding,
                       PropertiesProviding,
                       AttributesProviding,
                       FunctionsProviding,
                       InitializersProviding {}
