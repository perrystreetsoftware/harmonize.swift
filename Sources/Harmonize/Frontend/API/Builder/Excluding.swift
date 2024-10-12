//
//  Excluding.swift
//  Harmonize
//
//  Copyright (c) Perry Street Software 2024. All Rights Reserved.
//

/// Builder protocol to provide the functionality to exclude especific paths/folders/files from the Harmonize Scope.
public protocol Excluding: HarmonizeScope {
    /// The `excluding` builder method to filter out Files/Folders from the Harmonize Scope.
    ///
    /// - Parameter excludes: files, paths or folders to be excluded.
    /// - Returns: ``HarmonizeScope``.
    func excluding(_ excludes: String...) -> HarmonizeScope
}
