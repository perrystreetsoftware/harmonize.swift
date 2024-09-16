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
        let projectPath = try URLResolver.resolveProjectRootPath(#file)
        let mainPackageFile = projectPath.appendingPathComponent("Package.swift")
        XCTAssertTrue(FileManager.default.fileExists(atPath: mainPackageFile.path))
    }
}
