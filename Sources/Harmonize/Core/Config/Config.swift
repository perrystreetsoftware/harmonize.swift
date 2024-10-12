//
//  Config.swift
//  Harmonize
//
//  Copyright (c) Perry Street Software 2024. All Rights Reserved.
//

import Foundation
import Yams

/// The model representation for `.harmonize.yaml`.
/// This model is that simple because it is more of a workaround to get the project working directory.
///
/// Harmonize shall work normally even if these properties are empty because we have APIs to resolve packages, folders
/// and test folders.
public struct Config: Equatable {
    /// The collection of paths were Harmonize will not include when searching for Swift Files.
    public let excludePaths: [String]
    
    public init(excludePaths: [String]) {
        self.excludePaths = excludePaths
    }
}

// MARK: - FileError

public extension Config {
    enum FileError: Error, Equatable {
        case configFileNotFound
    }
}

// MARK: - Decodable

extension Config: Decodable {
    private enum CodingKeys: String, CodingKey {
        case excludes
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        let excludes = try? values.decode([String].self, forKey: .excludes)
        
        excludePaths = excludes ?? []
    }
    
    internal init(file: StaticString) {
        let resolveProjectConfigFilePath = ResolveProjectConfigFilePath()
        let content = try! String(contentsOfFile: resolveProjectConfigFilePath(file).path)
        try! self.init(content)
    }
    
    internal init(_ yaml: String) throws {
        guard !yaml.isEmpty else {
            excludePaths = []
            return
        }
        
        let decoded = try YAMLDecoder().decode(Self.self, from: yaml)
        excludePaths = decoded.excludePaths
    }
}
