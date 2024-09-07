//
//  PathKitTests.swift
//
//
//  Created by Lucas Cavalcante on 9/6/24.
//

import Foundation
import XCTest
@testable import Harmonize

final class URLResolverTests: XCTestCase {
    func testAssertCanResolveProjectPath() throws {
        let projectPath = try URLResolver.resolveProjectRootPath()
        let mainPackageFile = projectPath.appendingPathComponent("Package.swift")
        XCTAssertTrue(FileManager.default.fileExists(atPath: mainPackageFile.path))
    }
    
    func testAssertFailureIfConfigFileIsNotPresent() throws {
        let startingAt = URL(fileURLWithPath: "/dummy")
        XCTAssertThrowsError(try URLResolver.resolveProjectRootPath(startingAt)) { error in
            XCTAssertEqual(
                error as! HarmonizeError,
                HarmonizeError.configFileNotFound
            )
        }
    }
}
