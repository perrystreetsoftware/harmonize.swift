import Foundation

public protocol Class: Declaration,
                       FileSourceProviding,
                       InheritanceProviding,
                       PropertiesProviding,
                       AttributesProviding,
                       FunctionsProviding,
                       InitializersProviding {}
