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
        var model = ClassDeclSyntaxModel(node: node, file: file)
        model.children = withUpdatedChildrenParent(parent: model)
        return model
    }
    
    func create(_ node: FunctionDeclSyntax) -> Function {
        var model = FunctionDeclSyntaxModel(node: node, file: file)
        model.children = withUpdatedChildrenParent(parent: model)
        return model
    }
    
    func create(_ node: FunctionParameterSyntax) -> Parameter {
        ParameterSyntaxModel(node: node, file: file)
    }
    
    func create(_ node: StructDeclSyntax) -> Struct {
        var model = StructDeclSyntaxModel(node: node, file: file)
        model.children = withUpdatedChildrenParent(parent: model)
        return model
    }
    
    func create(_ node: VariableDeclSyntax) -> [Property] {
        VariableDeclSyntaxModel.create(from: node)
    }
    
    func create(_ node: ProtocolDeclSyntax) -> ProtocolDeclaration {
        var model = ProtocolDeclSyntaxModel(node: node, file: file)
        model.children = withUpdatedChildrenParent(parent: model)
        return model
    }
    
    func create(_ node: InitializerDeclSyntax) -> Initializer {
        var model = InitializerDeclSyntaxModel(node: node, file: file)
        model.children = withUpdatedChildrenParent(parent: model)
        return model
    }
    
    func create(_ node: EnumDeclSyntax) -> Enum {
        var model = EnumDeclSyntaxModel(node: node, file: file)
        model.children = withUpdatedChildrenParent(parent: model)
        return model
    }
    
    func create(_ node: EnumCaseDeclSyntax) -> [EnumCase] {
        EnumCaseDeclSyntaxModel.create(from: node)
    }
    
    private func withUpdatedChildrenParent(parent: Declaration) -> [Declaration] {
        children.map {
            var symbol = $0
            symbol.parent = parent
            return symbol
        }
    }
}
