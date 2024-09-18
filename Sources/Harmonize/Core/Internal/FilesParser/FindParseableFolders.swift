//
//  FindParseableFolders.swift
//
//
//  Created by Lucas Cavalcante on 9/18/24.
//

import Foundation

/// The class responsible for looking through a given directory URL and finding all folders URL matching the given path component.
///
/// Useful when you have a multi-modular project and when you want to write lint rules on top of similar modules between modules.
/// Calling `findFolders(containing: "Models", at: ...)` will return the path for every folder containing "Models".
internal final class FindParseableFolders {
    func callAsFunction(containing pathComponent: String, in directory: URL) -> [URL] {
        guard let enumerator = FileManager.default.enumerator(
            at: directory,
            includingPropertiesForKeys: [.isDirectoryKey],
            options: [.skipsHiddenFiles]
        )
        else { return [] }
        
        var folders = [URL]()
        
        for case let url as URL in enumerator {
            let isDirectory = try? url.resourceValues(forKeys: [.isDirectoryKey]).isDirectory
            
            if isDirectory ?? false {
                if url.pathComponents.joined(separator: "/").contains(pathComponent) {
                    folders.append(url)
                    enumerator.skipDescendants()
                }
            }
        }
        
        return folders
    }
}
