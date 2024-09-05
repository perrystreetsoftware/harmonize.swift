import Foundation

public protocol Struct: Declaration,
                        NamedDeclaration,
                        ParentDeclarationProviding,
                        ChildrenDeclarationProviding,
                        FileSourceProviding,
                        InheritanceProviding,
                        PropertiesProviding,
                        AttributesProviding,
                        FunctionsProviding,
                        InitializersProviding {}
