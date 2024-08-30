import Foundation
import SwiftSyntax
import SwiftParser

public class HarmonizeFileVisitor: SyntaxVisitor {
    /// Top-level node of the file tree
    private var rootNode: Node = .root(declarations: [])
    
    public let sourceFile: SwiftFile
    
    public var declarations: [SwiftDeclaration] = []
    
    public var rootDeclarations: [SwiftDeclaration] {
        rootNode.declarations
    }
    
    public init(sourceFile: SwiftFile) throws {
        self.sourceFile = sourceFile
        super.init(viewMode: .fixedUp)
        
        let source = try Parser.parse(source: String(contentsOf: sourceFile.filePath))
        walk(source)
        declarations.append(contentsOf: rootDeclarations)
    }
    
    public override func visit(_ node: ClassDeclSyntax) -> SyntaxVisitorContinueKind {
        startNode()
    }
    
    public override func visitPost(_ node: ClassDeclSyntax) {
        endNode { $0.create(node) }
    }
    
    public override func visit(_ node: FunctionDeclSyntax) -> SyntaxVisitorContinueKind {
        startNode()
    }
    
    public override func visitPost(_ node: FunctionDeclSyntax) {
        endNode { $0.create(node) }
    }
    
    public override func visit(_ node: FunctionParameterSyntax) -> SyntaxVisitorContinueKind {
        startNode()
    }
    
    public override func visitPost(_ node: FunctionParameterSyntax) {
        endNode { $0.create(node) }
    }
    
    public override func visit(_ node: ProtocolDeclSyntax) -> SyntaxVisitorContinueKind {
        startNode()
    }
    
    public override func visitPost(_ node: ProtocolDeclSyntax) {
        endNode { $0.create(node) }
    }
    
    public override func visit(_ node: StructDeclSyntax) -> SyntaxVisitorContinueKind {
        startNode()
    }
    
    public override func visitPost(_ node: StructDeclSyntax) {
        endNode { $0.create(node) }
    }
    
    public override func visit(_ node: InitializerDeclSyntax) -> SyntaxVisitorContinueKind {
        startNode()
    }
    
    public override func visitPost(_ node: InitializerDeclSyntax) {
        endNode { $0.create(node) }
    }

    public override func visit(_ node: VariableDeclSyntax) -> SyntaxVisitorContinueKind {
        startNode()
    }
    
    public override func visitPost(_ node: VariableDeclSyntax) {
        endNodeWithNestedDeclarations { $0.create(node) }
    }
    
    private func startNode() -> SyntaxVisitorContinueKind {
        rootNode.start()
        return .visitChildren
    }
    
    private func endNode(build: (SwiftDeclarationFactory) -> SwiftDeclaration) {
        rootNode.end(build: {
            let declaration = build(SwiftDeclarationFactory(file: sourceFile, children: $0))
            appendChildrenToDeclarations(children: declaration.children)
            return declaration
        })
    }
    
    private func endNodeWithNestedDeclarations(buildMany: (SwiftDeclarationFactory) -> [SwiftDeclaration]) {
        rootNode.end(buildMany: {
            let declarations = buildMany(SwiftDeclarationFactory(file: sourceFile, children: $0))
            appendChildrenToDeclarations(children: declarations.flatMap { $0.children })
            return declarations
        })
    }
    
    private func appendChildrenToDeclarations(children: [SwiftDeclaration]) {
        self.declarations.append(contentsOf: children)
    }
}

fileprivate extension Node {
    mutating func start() {
        self = .nested(node: self, declarations: [])
    }

    mutating func end(build: (_ children: [SwiftDeclaration]) -> SwiftDeclaration) {
        let declaration = build(declarations)

        switch self {
        case .root:
            fatalError("Unexpected root scope post visiting syntax. Make sure start() and end() are called correctly.")

        case let .nested(.root(rootDeclarations), _):
            self = .root(declarations: rootDeclarations + [declaration])

        case let .nested(.nested(parent, parentDeclarations), _):
            self = .nested(node: parent, declarations: parentDeclarations + [declaration])
        }
    }
    
    /// Ends a node while building an array of declarations usually flattened from a given declarations.
    /// For example, it's usefol to inline SwiftProperty into an array of SwiftProperty when detected that it has multiple definitions and is considered as a single property by Swift Syntax.
    ///
    /// For instance, `var a, b, c, d: Long = 1` is transformed into an array of SwiftProperty instead of a single SwiftProperty.
    ///
    /// Inline declarations will always have the top-most symbol as their parent.
    mutating func end(buildMany: (_ children: [SwiftDeclaration]) -> [SwiftDeclaration]) {
        let newDeclarations = buildMany(declarations)

        switch self {
        case .root:
            fatalError("Unexpected root scope post visiting syntax. Make sure start() and end() are called correctly.")

        case let .nested(.root(rootDeclarations), _):
            self = .root(declarations: rootDeclarations + newDeclarations)

        case let .nested(.nested(parent, parentDeclarations), _):
            self = .nested(node: parent, declarations: parentDeclarations + newDeclarations)
        }
    }
}
