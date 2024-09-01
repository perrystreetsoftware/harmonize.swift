import Foundation

public protocol Struct: Declaration,
                        FileSourceProviding,
                        InheritanceProviding,
                        PropertiesProviding,
                        AttributesProviding,
                        FunctionsProviding,
                        InitializersProviding {}
