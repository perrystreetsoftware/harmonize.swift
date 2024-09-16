//
//  FiltersTests.swift
//  
//
//  Created by Lucas Cavalcante on 9/15/24.
//

import Foundation
import Harmonize
import XCTest

final class FiltersTests: XCTestCase {
    let scope = Harmonize.productionCode()
        .on("Fixtures/SampleApp")
    
    func testNamedDeclarationsFilters() throws {
        scope.classes(includeNested: true)
            .withSuffix("UseCase")
            .assertCount(count: 2)
        
        scope.classes(includeNested: true)
            .withoutSuffix("UseCase")
            .assertCount(count: 1)
        
        scope.classes(includeNested: true)
            .withPrefix("Fetch")
            .assertCount(count: 2)
        
        scope.classes(includeNested: true)
            .withoutPrefix("Fetch")
            .assertCount(count: 1)
        
        scope.classes(includeNested: true)
            .withNameContaining("User", "Converter")
            .assertCount(count: 3)
        
        scope.classes(includeNested: true)
            .withoutNameContaining("User", "Converter")
            .assertEmpty()
    }
}
