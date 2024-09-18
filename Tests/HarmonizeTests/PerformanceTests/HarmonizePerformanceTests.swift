//
//  HarmonizePerformanceTests.swift
//
//
//  Created by Lucas Cavalcante on 9/18/24.
//

import Foundation
import XCTest
@testable import Harmonize

final class HarmonizePerformanceTests: XCTestCase {
    let scope = Harmonize.productionAndTestCode()
    
    func testHarmonizePerformance() {
        self.measure {
            scope.declarations(includeNested: true).assertNotEmpty()
        }
    }
}
