//
//  Function.swift
//
//
//  Created by Lucas Cavalcante on 8/26/24.
//

import Foundation

public protocol Function: Declaration,
                        FileSourceProviding,
                        BodyProviding,
                        ParametersProviding,
                        ModifiersProviding,
                        FunctionsProviding {
    var returnClause: ReturnClause { get }
    
    var genericClause: String? { get }
    
    var whereClause: String? { get }
}
