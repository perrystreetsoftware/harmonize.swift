//
//  EnumCaseParameter.swift
//
//
//  Created by Lucas Cavalcante on 9/5/24.
//

import Foundation

public protocol EnumCaseParameter: Declaration, TypeAnnotationProviding {
    var label: String? { get }
}
