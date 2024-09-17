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
    }
    
    func testInheritanceProvidingFilters() throws {
        let scope = Harmonize.productionCode().on("Fixtures/Filters/Inheritance")

        scope.classes(includeNested: true)
            .inheriting(BaseUseCase.self)
            .assertCount(count: 1)
        
        scope.classes(includeNested: true)
            .inheriting(name: "BaseUseCase")
            .assertCount(count: 1)
        
        scope.structs(includeNested: true)
            .conforming(AgedUserModel.self)
            .assertCount(count: 1)
        
        scope.structs(includeNested: true)
            .conforming(names: "AgedUserModel")
            .assertCount(count: 1)
    }
    
    func testAttributesProvidingFilters() throws {
        let scope = Harmonize.productionCode().on("Fixtures/Filters/Attributes")
        
        scope.properties(includeNested: true)
            .withPropertyWrapper(Published<Int>.self)
            .assertCount(count: 2)
        
        scope.properties(includeNested: true)
            .withAttribute { $0.name == "@objc" }
            .assertEmpty()
        
        scope.properties(includeNested: true)
            .withAttribute(named: "@objc")
            .assertEmpty()
        
        scope.properties(includeNested: true)
            .withAttribute(named: "@Published")
            .assertCount(count: 2)
        
        scope.properties(includeNested: true)
            .withAttribute(annotation: .published)
            .assertCount(count: 2)
    }
}
