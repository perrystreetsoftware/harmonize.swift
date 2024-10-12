//
//  HarmonizePerformanceTests.swift
//  Harmonize
//
//  Copyright (c) Perry Street Software 2024. All Rights Reserved.
//

import Foundation
import XCTest
@testable import Harmonize

final class HarmonizePerformanceTests: XCTestCase {
    let scope = Harmonize.productionAndTestCode()
    
    func testHarmonizePerformance() {
        self.measure {
            scope.classes().assertNotEmpty()
        }
    }
}
