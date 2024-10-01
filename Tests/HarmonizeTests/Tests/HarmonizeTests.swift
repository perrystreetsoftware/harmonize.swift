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
    private let productionAndTestCode = Harmonize.productionAndTestCode()
        .on("Fixtures/SampleApp")
    
    private let productionCode = Harmonize.productionCode()
        .on("Fixtures/SampleApp")
    
    private let testCode = Harmonize.testCode()
        .on("Fixtures/SampleApp")
    
    func testCreatesScopesWithProductionAndTestCode() throws {
        let scope = productionAndTestCode
        let fileNames = scope.files().map { $0.fileName }
        let edgeCases = ["MathTests.swift", "UseCases.swift", "ModelsTests.swift"]
        
        XCTAssertEqual(scope.files().count, 5)
        
        for edgeCase in edgeCases {
            XCTAssert(fileNames.contains(edgeCase), "\(edgeCase) not found in \(fileNames)")
        }
    }
    
    func testCreatesScopesWithProductionAndTestCodeExcludingFiles() throws {
        let scope = productionAndTestCode
            .excluding("MathTests.swift", "UseCases.swift", "ModelsTests.swift")
        
        let fileNames = scope.files().map { $0.fileName }
        
        XCTAssertEqual(scope.files().count, 2)
        
        for excluded in ["MathTests.swift", "UseCases.swift", "ModelsTests.swift"] {
            XCTAssert(!fileNames.contains(excluded), "\(excluded) found in \(fileNames)")
        }
    }
    
    func testCreatesScopesWithProductionAndTestCodeExcludingPath() throws {
        let scope = productionAndTestCode.excluding("Tests")
        let fileNames = scope.files().map { $0.fileName }
        
        XCTAssertEqual(scope.files().count, 2)
        
        for excluded in ["MathTests.swift", "UseCasesTests.swift", "ModelsTests.swift"] {
            XCTAssert(!fileNames.contains(excluded), "\(excluded) found in \(fileNames)")
        }
    }

    func testCreatesScopesWithProductionCode() throws {
        let isOnlyProductionCode = productionCode.files()
            .map { $0.fileName }
            .contains {
                ["Models.swift", "UseCases.swift"].contains($0)
            }
    
        XCTAssertTrue(isOnlyProductionCode)
    }
    
    func testCreatesScopesWithTestCode() throws {
        let isOnlyTestCode = testCode.files()
            .map { $0.fileName }
            .contains {
                ["MathTests.swift", "UseCasesTests.swift", "ModelsTests.swift"].contains($0)
            }

        XCTAssertTrue(isOnlyTestCode)
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
