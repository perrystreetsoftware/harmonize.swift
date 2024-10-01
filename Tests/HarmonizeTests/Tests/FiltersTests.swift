//
//  FiltersTests.swift
//  
//
//  Created by Lucas Cavalcante on 9/15/24.
//

import Foundation
@testable import Harmonize
import XCTest

final class FiltersTests: XCTestCase {
    
    func testNamedDeclarationsFilters() throws {
        let scope = Harmonize.productionCode().on("Fixtures/Filters/NamedDeclarations")
        
        scope.classes(includeNested: true)
            .withSuffix("ViewModel")
            .assertCount(count: 3)
        
        scope.classes(includeNested: true)
            .withoutSuffix("ViewModel")
            .assertEmpty()
        
        scope.classes(includeNested: true)
            .withPrefix("Base")
            .assertCount(count: 1)
        
        scope.classes(includeNested: true)
            .withoutPrefix("Base")
            .assertCount(count: 2)
        
        scope.classes(includeNested: true)
            .withNameContaining("Base", "ViewModel")
            .assertCount(count: 3)
        
        scope.classes(includeNested: true)
            .withoutNameContaining("Base", "ViewModel")
            .assertEmpty()
        
        scope.classes(includeNested: true)
            .withoutName(["BaseViewModel", "AppMainViewModel"])
            .assertCount(count: 1)
        
        scope.classes(includeNested: true)
            .withName(["BaseViewModel"])
            .assertCount(count: 1)
    }
    
    func testInheritanceProvidingFilters() throws {
        let scope = Harmonize.productionCode().on("Fixtures/Filters/Inheritance")

        scope.classes(includeNested: true)
            .inheriting(BaseUseCase.self)
            .assertCount(count: 1)
        
        scope.classes(includeNested: true)
            .inheriting(from: "BaseUseCase")
            .assertCount(count: 1)
        
        scope.structs(includeNested: true)
            .conforming(to: AgedUserModel.self)
            .assertCount(count: 1)
        
        scope.structs(includeNested: true)
            .conforming(to: "AgedUserModel")
            .assertCount(count: 1)
        
        scope.classes(includeNested: true)
            .inheriting(from: "BaseUseCase")
            .assertTrue { $0.inherits(from: BaseUseCase.self) }
    }
    
    func testAttributesProvidingFilters() throws {
        let scope = Harmonize.productionCode().on("Fixtures/Filters/Attributes")
        
        scope.variables(includeNested: true)
            .withPropertyWrapper(Published<Int>.self)
            .assertCount(count: 2)
        
        scope.variables(includeNested: true)
            .withAttribute { $0.name == "@objc" }
            .assertEmpty()
        
        scope.variables(includeNested: true)
            .withAttribute(named: "@objc")
            .assertEmpty()
        
        scope.variables(includeNested: true)
            .withAttribute(named: "@Published")
            .assertCount(count: 2)
        
        scope.variables(includeNested: true)
            .withAttribute(annotation: .published)
            .assertCount(count: 2)
    }
    
    func testTypeAnnotationProvidingFilters() throws {
        let scope = Harmonize.productionCode().on("Fixtures/Filters/Types")
        
        scope.variables(includeNested: true)
            .withType(Int.self)
            .assertCount(count: 1)
        
        scope.variables(includeNested: true)
            .withInferredType()
            .assertCount(count: 1)
        
        scope.variables(includeNested: true)
            .withType(named: "AppMainViewModel")
            .assertCount(count: 1)
        
        scope.variables(includeNested: true)
            .withType(AppMainViewModel.self)
            .assertCount(count: 1)
        
        scope.variables(includeNested: true)
            .withType(String?.self)
            .assertCount(count: 1)
        
        scope.variables(includeNested: true)
            .withType { $0 == String?.self }
            .assertCount(count: 1)
    }
    
    func testBodyProvidingFilters() throws {
        let scope = Harmonize.productionCode().on("Fixtures/Filters/Body")
        
        scope.functions(includeNested: true)
            .withBody { $0.contains("makeACall()") }
            .assertCount(count: 1)
        
        scope.functions(includeNested: true)
            .withoutBody { $0.contains("makeACall()") }
            .assertNotEmpty()
    }
    
    func testModifiersProvidingFilters() throws {
        let scope = Harmonize.productionCode().on("Fixtures/Filters/Modifiers")
        
        scope.classes(includeNested: true)
            .withModifier(.final, .public)
            .assertCount(count: 1)
        
        scope.variables(includeNested: true)
            .withModifier(.public, .privateSet)
            .assertCount(count: 2)
        
        scope.variables(includeNested: true)
            .withoutModifier(.public)
            .assertCount(count: 1)
    }
    
    func testAccessorBlocksProvidingFilters() throws {
        let scope = Harmonize.productionCode().on("Fixtures/Filters/Accessors")
        let properties = scope.variables(includeNested: true)
        
        AccessorBlock.Modifier.allCases.forEach {
            properties.withAcessorBlockBody($0)
                .assertCount(count: 1)
        }
        
        properties.withGetter { $0?.contains("getter") ?? false }.assertNotEmpty()
        properties.withGet { $0?.contains("that's a get") ?? false }.assertNotEmpty()
        properties.withSet { $0?.contains("newValue") ?? false }.assertNotEmpty()
        properties.withDidSet { $0?.contains("didset") ?? false }.assertNotEmpty()
        properties.withWillSet { $0?.contains("willset") ?? false }.assertNotEmpty()
    }
    
    func testFileSourceProvidingFilters() throws {
        let scope = Harmonize.productionCode().on("Fixtures/Filters/")
        scope.classes(includeNested: true)
            .withFileSource { $0.filePath.pathComponents.contains("NamedDeclarations") }
            .assertCount(count: 3)
    }
    
    func testFunctionsProvidingFilters() throws {
        let scope = Harmonize.productionCode().on("Fixtures/Filters/Functions")
        scope.classes(includeNested: true)
            .withFunctions { $0.modifiers.contains(.private) }
            .assertCount(count: 1)
    }
    
    func testInitializeClauseProvidingFilters() throws {
        let scope = Harmonize.productionCode().on("Fixtures/Filters/InitializerClauses")
        scope.variables(includeNested: true)
            .withInitializerClause { $0.value.contains("42") }
            .assertCount(count: 2)
    }
    
    func testInitializersProvidingFilters() throws {
        let scope = Harmonize.productionCode().on("Fixtures/Filters/Initializers")
        
        scope.structs(includeNested: true)
            .withInitializers { $0.parameters.isEmpty }
            .assertCount(count: 1)
        
        scope.extensions()
            .withInitializers { !$0.parameters.isEmpty }
            .assertCount(count: 1)
    }
    
    func testParametersProvidingFilters() throws {
        let scope = Harmonize.productionCode().on("Fixtures/Filters/Variables")
        
        scope.initializers()
            .withParameters { $0.name == "parameter" }
            .assertCount(count: 1)
    }
    
    func testPropertiesProvidingFilters() throws {
        let scope = Harmonize.productionCode().on("Fixtures/Filters/Variables")
        
        scope.initializers()
            .withVariables { $0.name == "variable" }
            .assertCount(count: 1)
    }
}
