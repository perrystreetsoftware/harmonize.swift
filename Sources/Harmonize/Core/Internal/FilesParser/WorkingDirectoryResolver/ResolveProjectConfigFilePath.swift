//
//  ResolveProjectConfigFilePath.swift
//
//
//  Created by Lucas Cavalcante on 9/18/24.
//

import Foundation

internal final class ResolveProjectConfigFilePath {
    private let resolveProjectWorkingDirectory = ResolveProjectWorkingDirectory()
    
    func callAsFunction(_ file: StaticString) throws -> URL {
        try resolveProjectWorkingDirectory(file).appendingPathComponent(".harmonize.yaml")
    }
}
