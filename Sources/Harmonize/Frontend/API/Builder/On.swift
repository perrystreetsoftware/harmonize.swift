//
//  On.swift
//  Harmonize
//
//  Copyright (c) Perry Street Software 2024. All Rights Reserved.
//

/// Builder protocol to provide the functionality to lookup for especific paths/folders/packages into the working directory.
public protocol On: Excluding {
    /// A folder or path builder specifier to target Harmonize.
    ///
    /// - parameter folder: the target folder or path name as string.
    /// - returns: the Builder allowing filtering with `excluding` or Harmonize scope.
    ///
    /// Calling Harmonize.on("path/to/code") will effectivelly allow the work on the given path that must be a directory of the working directory.
    /// Additionally it is also possible to call Harmonize.on("Folder") and it will act on every directory it finds with the given name.
    ///
    func on(_ folder: String) -> Excluding
}
