//
//  ResolveProjectConfigFilePath.swift
//  Harmonize
//
//  Copyright (c) Perry Street Software 2024. All Rights Reserved.
//

import Foundation

internal final class ResolveProjectConfigFilePath {
    private let resolveProjectWorkingDirectory = ResolveProjectWorkingDirectory()
    
    func callAsFunction(_ file: StaticString) throws -> URL {
        try resolveProjectWorkingDirectory(file).appendingPathComponent(".harmonize.yaml")
    }
}
