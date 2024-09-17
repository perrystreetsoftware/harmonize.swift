//
//  EnumCaseParameter.swift
//
//
//  Created by Lucas Cavalcante on 9/5/24.
//

import Foundation

public struct EnumCaseParameter: Declaration,
                                 TypeAnnotationProviding,
                                 FileSourceProviding {
    public var text: String
    
    public var typeAnnotation: TypeAnnotation?
    
    public var label: String?
    
    public var swiftFile: SwiftFile
}
