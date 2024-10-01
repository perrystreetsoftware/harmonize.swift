import Foundation
import SwiftSyntax

class DeclarationFactory {
    private let file: SwiftFile
    private let children: [Declaration]
    
    init(file: SwiftFile, children: [Declaration]) {
        self.file = file
        self.children = children
    }
    
    func create(_ node: ClassDeclSyntax) -> Class {
        var model = Class(node: node, file: file)
        model.children = withUpdatedChildrenParent(parent: model)
        return model
    }
    
    func create(_ node: FunctionDeclSyntax) -> Function {
        var model = Function(node: node, file: file)
        model.children = withUpdatedChildrenParent(parent: model)
        return model
    }
    
    func create(_ node: FunctionParameterSyntax) -> Parameter {
        Parameter(node: node, file: file)
    }
    
    func create(_ node: FunctionCallExprSyntax) -> [FunctionCall] {
        [FunctionCall(text: node.calledExpression.trimmedDescription)] + children.as(FunctionCall.self)
    }
    
    func create(_ node: StructDeclSyntax) -> Struct {
        var model = Struct(node: node, file: file)
        model.children = withUpdatedChildrenParent(parent: model)
        return model
    }
    
    func create(_ node: VariableDeclSyntax) -> [Variable] {
        Variable.create(from: node, file: file)
    }
    
    func create(_ node: ProtocolDeclSyntax) -> ProtocolDeclaration {
        var model = ProtocolDeclaration(node: node, file: file)
        model.children = withUpdatedChildrenParent(parent: model)
        return model
    }
    
    func create(_ node: InitializerDeclSyntax) -> Initializer {
        var model = Initializer(node: node, file: file)
        model.children = withUpdatedChildrenParent(parent: model)
        return model
    }
    
    func create(_ node: EnumDeclSyntax) -> Enum {
        var model = Enum(node: node, file: file)
        model.children = withUpdatedChildrenParent(parent: model)
        return model
    }
    
    func create(_ node: EnumCaseDeclSyntax) -> [EnumCase] {
        EnumCase.create(from: node, file: file)
    }
    
    func create(_ node: ExtensionDeclSyntax) -> Extension {
        var model = Extension(node: node, file: file)
        model.children = withUpdatedChildrenParent(parent: model)
        return model
    }
    
    func create(_ node: ImportDeclSyntax) -> Import {
        Import(node, file)
    }
    
    private func withUpdatedChildrenParent(parent: Declaration) -> [Declaration] {
        children.map {
            if var symbol = $0 as? Declaration & ParentDeclarationProviding {
                symbol.parent = parent
                return symbol
            }
            
            return $0
        }
    }
}
