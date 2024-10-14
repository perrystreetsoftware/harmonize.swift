//
//  DeclarationsCollector.swift
//  Harmonize
//
//  Copyright (c) Perry Street Software 2024. All Rights Reserved.
//

import Foundation
import SwiftSyntax
import SwiftParser

/// A SyntaxVisitor implementation that collects top-level and nested declarations.
/// Not focused in performance yet and its behavior may be changed in the future.
package final class DeclarationsCollector: SyntaxVisitor {
    /// The original source location either from a file or raw string.
    private let sourceCodeLocation: SourceCodeLocation
    
    /// Collection of top-level and nested declarations.
    public private(set) var declarations: [Declaration] = []
    
    /// Collection of top-level only declarations.
    public private(set) var rootDeclarations: [Declaration] = []
    
    /// Collection of top-level swift class declarations.
    public private(set) var classes: [Class] = []

    /// Collection of top-level swift enums declarations.
    public private(set) var enums: [Enum] = []

    /// Collection of swift extensionsdeclarations.
    public private(set) var extensions: [Extension] = []

    /// Collection of top-level swift function declarations.
    public private(set) var functions: [Function] = []

    /// Collection of swift import declarations.
    public private(set) var imports: [Import] = []

    /// Collection of swift initializer declarations.
    public private(set) var initializers: [Initializer] = []

    /// Collection of top-level swift protocol declarations.
    public private(set) var protocols: [ProtocolDeclaration] = []

    /// Collection of top-level swift struct declarations.
    public private(set) var structs: [Struct] = []

    /// Collection of top-level swift variable declarations.
    public private(set) var variables: [Variable] = []

    package init(sourceCodeLocation: SourceCodeLocation) {
        self.sourceCodeLocation = sourceCodeLocation
        super.init(viewMode: .fixedUp)
    }
    
    private let declarationsCache = DeclarationsCache.shared
    
    // The current visiting stack<->declaration.
    private var stack: [(Syntax, Declaration)] = []
    
    // The map of nodes and its child declarations.
    private var nodes: [Syntax: [Declaration]] = [:]

    private var parentDeclaration: Declaration? {
        stack.last?.1
    }
    
    private var parentNode: Syntax? {
        stack.last?.0
    }
    
    public override func visit(_ node: ClassDeclSyntax) -> SyntaxVisitorContinueKind {
        let `class` = startScopeWith(node) {
            Class(node: node, parent: parentDeclaration, sourceCodeLocation: sourceCodeLocation)
        }
        classes.append(`class`)
        return .visitChildren
    }
    
    public override func visitPost(_ node: ClassDeclSyntax) {
        endScope(for: node)
    }
    
    public override func visit(_ node: FunctionDeclSyntax) -> SyntaxVisitorContinueKind {
        let function = startScopeWith(node) {
            Function(node: node, parent: parentDeclaration, sourceCodeLocation: sourceCodeLocation)
        }
        functions.append(function)
        return .visitChildren
    }
    
    public override func visitPost(_ node: FunctionDeclSyntax) {
        endScope(for: node)
    }
    
    public override func visit(_ node: ProtocolDeclSyntax) -> SyntaxVisitorContinueKind {
        let `protocol` = startScopeWith(node) {
            ProtocolDeclaration(node: node, parent: parentDeclaration, sourceCodeLocation: sourceCodeLocation)
        }
        protocols.append(`protocol`)
        return .visitChildren
    }
    
    public override func visitPost(_ node: ProtocolDeclSyntax) {
        endScope(for: node)
    }
    
    public override func visit(_ node: StructDeclSyntax) -> SyntaxVisitorContinueKind {
        let `struct` = startScopeWith(node) {
            Struct(node: node, parent: parentDeclaration, sourceCodeLocation: sourceCodeLocation)
        }
        structs.append(`struct`)
        return .visitChildren
    }
    
    public override func visitPost(_ node: StructDeclSyntax) {
        endScope(for: node)
    }
    
    public override func visit(_ node: InitializerDeclSyntax) -> SyntaxVisitorContinueKind {
        let `initializer` = startScopeWith(node) {
            Initializer(node: node, parent: parentDeclaration, sourceCodeLocation: sourceCodeLocation)
        }
        initializers.append(`initializer`)
        return .visitChildren
    }
    
    public override func visitPost(_ node: InitializerDeclSyntax) {
        endScope(for: node)
    }

    public override func visit(_ node: VariableDeclSyntax) -> SyntaxVisitorContinueKind {
        let vars = startScopeWith(node) {
            Variable.variables(from: node, parent: parentDeclaration, sourceCodeLocation: sourceCodeLocation)
        }
        variables.append(contentsOf: vars)
        return .visitChildren
    }
    
    public override func visitPost(_ node: VariableDeclSyntax) {
        endScope(for: node)
    }
    
    public override func visit(_ node: EnumDeclSyntax) -> SyntaxVisitorContinueKind {
        let `enum` = startScopeWith(node) {
            Enum(node: node, parent: parentDeclaration, sourceCodeLocation: sourceCodeLocation)
        }
        enums.append(`enum`)
        return .visitChildren
    }
    
    public override func visitPost(_ node: EnumDeclSyntax) {
        endScope(for: node)
    }
    
    public override func visit(_ node: EnumCaseDeclSyntax) -> SyntaxVisitorContinueKind {
        _ = startScopeWith(node) {
            EnumCase.cases(from: node, parent: parentDeclaration, sourceCodeLocation: sourceCodeLocation)
        }
        return .visitChildren
    }
    
    public override func visitPost(_ node: EnumCaseDeclSyntax) {
        endScope(for: node)
    }
    
    public override func visit(_ node: ExtensionDeclSyntax) -> SyntaxVisitorContinueKind {
        let `extension` = startScopeWith(node) {
            Extension(node: node, parent: parentDeclaration, sourceCodeLocation: sourceCodeLocation)
        }
        extensions.append(`extension`)
        return .visitChildren
    }
    
    public override func visitPost(_ node: ExtensionDeclSyntax) {
        endScope(for: node)
    }
    
    public override func visit(_ node: ImportDeclSyntax) -> SyntaxVisitorContinueKind {
        imports.append(Import(node: node, sourceCodeLocation: sourceCodeLocation))
        return .skipChildren
    }
    
    public override func visit(_ node: FunctionCallExprSyntax) -> SyntaxVisitorContinueKind {
        _ = startScopeWith(node) {
            FunctionCall(node: node, parent: parentDeclaration, sourceCodeLocation: sourceCodeLocation)
        }
        
        return .visitChildren
    }
    
    public override func visitPost(_ node: FunctionCallExprSyntax) {
        endScope(for: node)
    }
    
    private func startScopeWith<T: Declaration>(_ node: SyntaxProtocol, make: () -> [T]) -> [T] {
        let newDeclarations = make()
        
        guard !newDeclarations.isEmpty else { return [] }
        
        if parentDeclaration == nil {
            rootDeclarations.append(contentsOf: newDeclarations)
        }
        
        if let parentNode {
            nodes[parentNode, default: []].append(contentsOf: newDeclarations)
        }
        
        if let declaration = newDeclarations.first {
            stack.append((node._syntaxNode, declaration))
        }
        
        declarations.append(contentsOf: newDeclarations)
        
        return newDeclarations
    }
    
    private func startScopeWith<T: Declaration>(_ node: SyntaxProtocol, makeSingle: () -> T) -> T {
        let single = makeSingle()
        _ = startScopeWith(node, make: { [single] })
        return single
    }
    
    private func endScope(for node: SyntaxProtocol) {
        declarationsCache.put(children: nodes[node._syntaxNode, default: []], for: node)
        _ = stack.popLast()
    }
}
