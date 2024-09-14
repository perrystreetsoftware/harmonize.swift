//
//  URLResolver.swift
//
//
//  Created by Lucas Cavalcante on 9/6/24.
//

import Foundation

/// This class holds the responsibility of finding the project's working directory by traversing paths until
/// it finds the `.harmonize.yaml` file.
///
/// We could seek for `Package.swift` but that would work only for SPM projects. As far as we know, there is no easy way to find the project
/// working directory and we need to force the library's users to bundle their own `.harmonize.yaml` for this library to be able to find the project's working dir.
internal class URLResolver {
    private static let sourceFileURL = URL(fileURLWithPath: #file)
    
    private init() {}
    
    static func resolveProjectRootPath( _ startingAt: URL = sourceFileURL) throws -> URL {
        var startingDirectory = startingAt
        
        repeat {
            startingDirectory.appendPathComponent("..")
            startingDirectory.standardize()

            if startingDirectory.configFileExists {
                return startingDirectory
            }
        } while startingDirectory.path != "/"
        
        throw HarmonizeError.configFileNotFound
    }
    
    static func resolveConfigFilePath() throws -> URL {
        try resolveProjectRootPath().appendingPathComponent(".harmonize.yaml")
    }
}

fileprivate extension URL {
    var configFileExists: Bool {
        FileManager.default.fileExists(
            atPath: self.appendingPathComponent(".harmonize.yaml").path
        )
    }
}
