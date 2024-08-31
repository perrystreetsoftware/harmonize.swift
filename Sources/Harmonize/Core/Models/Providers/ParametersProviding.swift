//
//  ParametersProviding.swift
//  
//
//  Created by Lucas Cavalcante on 8/26/24.
//

import Foundation

public protocol ParametersProviding {
    /// All parameters the declaration has.
    var parameters: [Parameter] { get }
}
