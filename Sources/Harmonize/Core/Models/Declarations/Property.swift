import Foundation

public protocol Property: Declaration,
                          ModifiersProviding,
                          AttributesProviding,
                          AccessorBlocksProviding,
                          TypeAnnotationProviding,
                          InitializerClauseProviding {
    var isOptional: Bool { get }
    
    var isConstant: Bool { get }
    
    var isVariable: Bool { get }
    
    var isOfInferredType: Bool { get }
}
