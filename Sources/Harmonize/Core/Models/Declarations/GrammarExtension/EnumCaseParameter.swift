//
//  EnumCaseParameter.swift
//
//
//  Created by Lucas Cavalcante on 9/5/24.
//

import Foundation

public struct EnumCaseParameter: Equatable {
    public var label: String?
    
    public var typeAnnotation: TypeAnnotation
    
    public init(label: String? = nil, typeAnnotation: TypeAnnotation) {
        self.label = label
        self.typeAnnotation = typeAnnotation
    }
}
