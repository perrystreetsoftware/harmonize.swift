//
//  Config.swift
//
//
//  Created by Lucas Cavalcante on 9/7/24.
//

import Foundation

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
