//
//  Initializer.swift
//
//
//  Created by Lucas Cavalcante on 8/28/24.
//

import Foundation

public protocol Initializer: Declaration,
                             BodyProviding,
                             ModifiersProviding,
                             AttributesProviding,
                             ParametersProviding,
                             InitializersProviding,
                             FunctionsProviding,
                             PropertiesProviding {}
