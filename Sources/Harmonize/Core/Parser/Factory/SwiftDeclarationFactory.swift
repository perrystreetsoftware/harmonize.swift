import Foundation
import SwiftSyntax

class SwiftDeclarationFactory {
    private let file: SwiftFile
    private let children: [SwiftDeclaration]
    
    private let initializerClauseConverter = InitializerClauseSyntaxConverter()
    private let declModifierSyntaxConverter = DeclModifierSyntaxConverter()
    private let attributeSyntaxConverter = AttributeSyntaxConverter()
    
    init(file: SwiftFile, children: [SwiftDeclaration]) {
        self.file = file
        self.children = children
    }
    
    func create(_ node: ClassDeclSyntax) -> SwiftClass {
        var `class` = SwiftClass(
            name: node.name.text,
            text: node.trimmedDescription,
            parent: nil,
            swiftFile: file,
            inheritanceTypesNames: node.inheritanceClause?.typesAsString() ?? [],
            children: [],
            attributes: attributeSyntaxConverter.convert(node.attributes)
        )
                
        let children = withUpdatedChildrenParent(parent: `class`)
        
        `class`.children = children
        
        return `class`
    }
    
    func create(_ node: FunctionDeclSyntax) -> SwiftFunction {
        let modifiers = declModifierSyntaxConverter.convert(node.modifiers)
        
        // TODO: make this type-safe in a future release?
        let genericClause = node.genericParameterClause?.trimmedDescription
        let whereClause = node.genericWhereClause?.trimmedDescription
        
        var function = SwiftFunction(
            name: node.name.text,
            text: node.trimmedDescription,
            children: [],
            modifiers: modifiers,
            returnClause: SwiftReturnClause.from(node.signature.returnClause?.type.trimmedDescription),
            genericClause: genericClause,
            whereClause: whereClause,
            body: node.body?.statements.map { $0.item.trimmedDescription }.joined(separator: "\n")
        )
        
        let children = withUpdatedChildrenParent(parent: function)
        function.children = children
        
        return function
    }
    
    func create(_ node: FunctionParameterSyntax) -> SwiftParameter {
        let firstName = node.firstName.text
        let secondName = node.secondName?.text
        
        let label = firstName == "_" ? "" : firstName
        
        let modifiers = declModifierSyntaxConverter.convert(node.modifiers)
        var attributes = attributeSyntaxConverter.convert(node.attributes)
        
        if let attributedTypeAttributes = node.type.as(AttributedTypeSyntax.self) {
            attributes.append(
                contentsOf: attributeSyntaxConverter.convert(attributedTypeAttributes.attributes)
            )
        }
        
        let variadic = node.ellipsis?.text ?? ""

        return SwiftParameter(
            name: secondName ?? firstName,
            text: node.trimmedDescription.replacingOccurrences(of: ",", with: ""),
            children: [],
            modifiers: modifiers,
            attributes: attributes,
            label: label,
            typeAnnotation: node.type.trimmedDescription + variadic,
            defaultValue: initializerClauseConverter.convert(node.defaultValue)?.value,
            isOptional: node.type.is(OptionalTypeSyntax.self),
            isVariadic: node.ellipsis != nil
        )
    }
    
    func create(_ node: StructDeclSyntax) -> SwiftStruct {
        var `struct` = SwiftStruct(
            name: node.name.text,
            text: node.trimmedDescription,
            parent: nil,
            swiftFile: file,
            inheritanceTypesNames: node.inheritanceClause?.typesAsString() ?? [],
            children: [],
            attributes: attributeSyntaxConverter.convert(node.attributes)
        )
                
        let children = withUpdatedChildrenParent(parent: `struct`)
        
        `struct`.children = children
        
        return `struct`
    }
    
    func create(_ node: VariableDeclSyntax) -> [SwiftProperty] {
        let patternBindingSyntaxConverter = PatternBindingSyntaxConverter(bindings: node.bindings)
                
        let identifiers = patternBindingSyntaxConverter.identifiers
        let annotations = patternBindingSyntaxConverter.types
        let initializers = patternBindingSyntaxConverter.initializers
        let accessors = patternBindingSyntaxConverter.accessors
        
        let modifiers = declModifierSyntaxConverter.convert(node.modifiers)
        let attributes = attributeSyntaxConverter.convert(node.attributes)
        
        var variables: [SwiftProperty] = []
        
        for (index, identifier) in identifiers.enumerated() {
            let annotation = index < annotations.count ? annotations[index] : annotations.last
            let initializer = index < initializers.count ? initializers[index] : nil
            
            let variable = SwiftProperty(
                name: identifier.name,
                text: node.trimmedDescription,
                children: children,
                modifiers: modifiers,
                attributes: attributes,
                accessors: accessors,
                typeAnnotation: annotation?.name ?? "",
                declarationType: .fromValue(node.bindingSpecifier.text),
                initializer: initializer?.value ?? "",
                isOptional: annotation?.isOptional ?? false
            )
            
            variables.append(variable)
        }
        
        return variables
    }
    
    func create(_ node: ProtocolDeclSyntax) -> SwiftProtocol {
        var `protocol` = SwiftProtocol(
            name: node.name.text,
            text: node.trimmedDescription,
            parent: nil,
            swiftFile: file,
            inheritanceTypesNames: node.inheritanceClause?.typesAsString() ?? [],
            children: [],
            attributes: attributeSyntaxConverter.convert(node.attributes)
        )
                
        let children = withUpdatedChildrenParent(parent: `protocol`)
        
        `protocol`.children = children
        
        return `protocol`
    }
    
    func create(_ node: InitializerDeclSyntax) -> SwiftInitializer {
        let modifiers = declModifierSyntaxConverter.convert(node.modifiers)
        let attributes = attributeSyntaxConverter.convert(node.attributes)
        
        var `init` = SwiftInitializer(
            name: node.trimmedDescription,
            text: node.trimmedDescription,
            children: [],
            modifiers: modifiers,
            attributes: attributes,
            body: node.body?.statements.trimmedDescription
        )
                
        let children = withUpdatedChildrenParent(parent: `init`)
        
        `init`.children = children
        
        return `init`
    }
    
    private func withUpdatedChildrenParent(parent: SwiftDeclaration) -> [SwiftDeclaration] {
        children.map {
            var symbol = $0
            symbol.parent = parent
            return symbol
        }
    }
}
