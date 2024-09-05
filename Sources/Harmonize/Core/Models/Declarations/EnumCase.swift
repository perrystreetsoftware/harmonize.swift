//
//  EnumCase.swift
//
//
//  Created by Lucas Cavalcante on 9/5/24.
//

import Foundation

public protocol EnumCase: Declaration,
                          AttributesProviding,
                          ModifiersProviding,
                          InitializerClauseProviding {
    var parameters: [EnumCaseParameter] { get }
}
