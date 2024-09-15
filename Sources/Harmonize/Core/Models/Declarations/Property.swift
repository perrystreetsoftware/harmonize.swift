import Foundation

public struct Property: Declaration,
                        NamedDeclaration,
                        ParentDeclarationProviding,
                        ModifiersProviding,
                        AttributesProviding,
                        AccessorBlocksProviding,
                        TypeAnnotationProviding,
                        InitializerClauseProviding {
    public var name: String
    
    public var text: String
    
    public var parent: Declaration?
        
    public var modifiers: [Modifier]
    
    public var attributes: [Attribute]
    
    public var accessorBlocks: [AccessorBlock]
    
    public var typeAnnotation: TypeAnnotation?
    
    public var initializerClause: InitializerClause?
    
    public var isConstant: Bool
    
    public var isOptional: Bool {
        typeAnnotation?.isOptional == true
    }
    
    public var isVariable: Bool {
        !isConstant
    }
    
    public var isOfInferredType: Bool {
        typeAnnotation == nil
    }
}
