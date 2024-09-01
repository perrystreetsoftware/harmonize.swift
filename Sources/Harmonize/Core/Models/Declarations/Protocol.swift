import Foundation

public protocol ProtocolDeclaration: Declaration,
                                     FileSourceProviding,
                                     InheritanceProviding,
                                     PropertiesProviding,
                                     AttributesProviding,
                                     FunctionsProviding,
                                     InitializersProviding {}
