//
//  HarmonizeTests.swift
//
//
//  Created by Lucas Cavalcante on 9/5/24.
//

import Foundation
import Harmonize
import XCTest

final class HarmonizeTests: XCTestCase {
    func testCreatesScopesWithProductionAndTestCode() throws {
        let scope = Harmonize.productionAndTestCode()
            .on("Fixtures/SampleApp")
        
        let fileNames = scope.files().map { $0.fileName }
        let edgeCases = ["MathTests.swift", "UseCases.swift", "ModelsTests.swift"]
        
        XCTAssertEqual(scope.files().count, 5)
        
        for edgeCase in edgeCases {
            XCTAssert(fileNames.contains(edgeCase), "\(edgeCase) not found in \(fileNames)")
        }
    }
    
    func testCreatesScopesWithProductionAndTestCodeExcludingFiles() throws {
        let scope = Harmonize.productionAndTestCode()
            .on("Fixtures/SampleApp")
            .excluding("MathTests.swift", "UseCases.swift", "ModelsTests.swift")
        
        let fileNames = scope.files().map { $0.fileName }
        
        XCTAssertEqual(scope.files().count, 2)
        
        for excluded in ["MathTests.swift", "UseCases.swift", "ModelsTests.swift"] {
            XCTAssert(!fileNames.contains(excluded), "\(excluded) found in \(fileNames)")
        }
    }
    
    func testCreatesScopesWithProductionAndTestCodeExcludingPath() throws {
        let scope = Harmonize.productionAndTestCode()
            .on("Fixtures/SampleApp")
            .excluding("Tests")
        
        let fileNames = scope.files().map { $0.fileName }
        
        XCTAssertEqual(scope.files().count, 2)
        
        for excluded in ["MathTests.swift", "UseCasesTests.swift", "ModelsTests.swift"] {
            XCTAssert(!fileNames.contains(excluded), "\(excluded) found in \(fileNames)")
        }
    }

    func testCreatesScopesWithProductionCode() throws {
        let scope = Harmonize.productionCode()
            .on("Fixtures/SampleApp")
        
        let fileNames = scope.files().map { $0.fileName }
    
        XCTAssertEqual(scope.files().count, 2)
        XCTAssertEqual(fileNames, ["Models.swift", "UseCases.swift"])
    }
    
    func testCreatesScopesWithTestCode() throws {
        let scope = Harmonize.testCode()
            .on("Fixtures/SampleApp")
        
        let fileNames = scope.files().map { $0.fileName }
    
        XCTAssertEqual(scope.files().count, 3)
        XCTAssertEqual(fileNames, ["MathTests.swift", "ModelsTests.swift", "UseCasesTests.swift"])
    }
    
    func testCreatesScopesMatchingFolder() throws {
        // Grab every test code contained in "Sources" folder
        // Certainly empty because Sources must have no Tests on this project.
        let scope = Harmonize.testCode()
            .on("Sources")
        
        // Grab every production code in "Sources" folder.
        let prodScope = Harmonize.productionCode()
            .on("Sources")
        
        // Sources must have no test code
        XCTAssertTrue(scope.files().isEmpty)
        XCTAssertTrue(!prodScope.files().isEmpty)
        XCTAssertTrue(prodScope.files().contains { !$0.fileName.hasSuffix("Tests") })
    }
}
