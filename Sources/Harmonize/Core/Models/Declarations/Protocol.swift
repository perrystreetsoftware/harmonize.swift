import Foundation

public protocol ProtocolDeclaration: Declaration,
                                     NamedDeclaration,
                                     ParentDeclarationProviding,
                                     ChildrenDeclarationProviding,
                                     FileSourceProviding,
                                     InheritanceProviding,
                                     PropertiesProviding,
                                     AttributesProviding,
                                     FunctionsProviding,
                                     InitializersProviding {}
