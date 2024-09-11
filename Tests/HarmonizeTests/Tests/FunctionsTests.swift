import Foundation
import Harmonize
import XCTest

final class FunctionsTests: XCTestCase {
    private var harmonize = TestUtils.harmonize(at: "Fixtures/Functions")
    
    func testAssertCanParseTopLevelFunctionsOnly() throws {
        let functions = harmonize.functions(includeNested: false)
        let functionNames = functions.map { $0.name }
        
        XCTAssertEqual(functions.count, 14)
        XCTAssertEqual(
            functionNames, 
            [
                "noArgLabelsFunction",
                "argLabelsFunction",
                "customArgLabelsFunction",
                "mixedLabeledArgsFunction",
                "variadic",
                "noLabelVariadic",
                "noLabelAtAll",
                "withReturnClause",
                "withGenericVariance",
                "withWhereClause",
                "withParametersInitializers",
                "withParametersAttributes",
                "fetchAllTheThings",
                "privateFunc"
            ]
        )
    }
    
    func testAssertCanParseFunctionsIncludingMemberFunctions() throws {
        let functions = harmonize.functions(includeNested: true)
        let functionNames = functions.map { $0.name }
        
        XCTAssertEqual(functions.count, 15)
        XCTAssertEqual(
            functionNames,
            [
                "nestedFunction",
                "noArgLabelsFunction",
                "argLabelsFunction",
                "customArgLabelsFunction",
                "mixedLabeledArgsFunction",
                "variadic",
                "noLabelVariadic",
                "noLabelAtAll",
                "withReturnClause",
                "withGenericVariance",
                "withWhereClause",
                "withParametersInitializers",
                "withParametersAttributes",
                "fetchAllTheThings",
                "privateFunc"
            ]
        )
    }
    
    func testAssertCanParseFunctionReturnClauses() throws {
        let functions = harmonize.functions(includeNested: true)
        let returnClauses = functions.map { $0.returnClause }
        
        XCTAssertEqual(
            returnClauses,
            [
                .type("String"),
                .absent,
                .absent,
                .absent,
                .absent,
                .absent,
                .absent,
                .absent,
                .type("String"),
                .type("R"),
                .type("Int"),
                .type("Int"),
                .type("Int"),
                .type("Int"),
                .absent
            ]
        )
    }
    
    func testAssertCanParseFunctionParametersWithNoArgLabels() throws {
        let function = named("noArgLabelsFunction")
        let parameters = function.parameters
        let labels = parameters.map { $0.label }
        XCTAssertEqual(labels, ["", ""])
    }
    
    func testAssertCanParseFunctionParametersWithArgLabels() throws {
        let function = named("argLabelsFunction")
        let parameters = function.parameters
        let labels = parameters.map { $0.label }
        XCTAssertEqual(labels, ["p1", "p2"])
    }
    
    func testAssertCanParseFunctionParametersWithCustomArgLabels() throws {
        let function = named("customArgLabelsFunction")
        let parameters = function.parameters
        
        let labels = parameters.map { $0.label }
        let names = parameters.map { $0.name }
        
        XCTAssertEqual(labels, ["param1", "param2"])
        XCTAssertEqual(names, ["p1", "param2"])
    }
    
    func testAssertCanParseFunctionParametersWithMixedArgLabels() throws {
        let function = named("mixedLabeledArgsFunction")
        let parameters = function.parameters
        
        let labels = parameters.map { $0.label }
        let names = parameters.map { $0.name }
        
        XCTAssertEqual(labels, ["p1", ""])
        XCTAssertEqual(names, ["p1", "p2"])
    }
    
    func testAssertCanParseVariadicFunctionParameters() throws {
        let variadicArg = named("variadic").parameters.first!
        let noLabelVariadicArg = named("noLabelVariadic").parameters.first!
        
        XCTAssertEqual(variadicArg.name, "args")
        XCTAssertEqual(variadicArg.label, "args")
        XCTAssertEqual(variadicArg.typeAnnotation?.name, "String...")
        XCTAssertEqual(variadicArg.isVariadic, true)
        XCTAssertEqual(noLabelVariadicArg.label, "")
    }
    
    func testAssertCanParseFunctionParametersWithNoNameAndLabels() throws {
        let unnamedParam = named("noLabelAtAll").parameters.first!
        XCTAssertEqual(unnamedParam.name, "_")
        XCTAssertEqual(unnamedParam.label, "")
        XCTAssertEqual(unnamedParam.typeAnnotation?.name, "String")
    }
    
    func testAssertCanParseFunctionParametersWithReturnClause() throws {
        let returnClause = named("withReturnClause").returnClause
        XCTAssertEqual(returnClause, .type("String"))
    }
    
    func testAssertCanParseFunctionParametersWithGenericClause() throws {
        let genericClause = named("withGenericVariance").genericClause
        XCTAssertEqual(genericClause, "<T, R>")
    }
    
    func testAssertCanParseFunctionParametersWithWhereClause() throws {
        let whereClause = named("withWhereClause").whereClause
        XCTAssertEqual(whereClause, "where T: Sendable")

    }
    
    func testAssertCanParseFunctionParametersWithInitializer() throws {
        let param = named("withParametersInitializers").parameters.first!
        XCTAssertEqual(param.initializerClause?.value, "Value")
    }
    
    func testAssertCanParseFunctionParametersWithAttributes() throws {
        let attributedParam = named("withParametersAttributes").parameters.first!
        XCTAssertEqual(attributedParam.attributes, [Attribute(name: "autoclosure", annotation: .autoclosure)])
    }
    
    func testAssertCanParseFunctionModifiers() throws {
        let asyncfunc = named("fetchAllTheThings")
        let privateFunc = named("privateFunc")
        
        XCTAssertEqual(asyncfunc.modifiers, [.public])
        XCTAssertEqual(privateFunc.modifiers, [.private])
    }
    
    func testAssertCanParseFunctionBody() throws {
        let functionBody = named("withReturnClause").body
        let body = """
        let cal = "cal"
        noLabelAtAll(cal)
        return "return"
        """
        XCTAssertEqual(functionBody, body)
    }
    
    private func named(_ name: String, includeNested: Bool = true) -> Function {
        harmonize.functions(includeNested: includeNested).first {
            $0.name == name
        }!
    }
}
