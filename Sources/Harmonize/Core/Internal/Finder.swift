//
//  Finder.swift
//
//
//  Created by Lucas Cavalcante on 9/9/24.
//

import Foundation

/// The internal implementation responsible for Swift File lookup through the source.
internal class Finder {
    internal func callAsFunction(
        workingDirectory: URL,
        folder: String?,
        inclusions: [String],
        exclusions: [String]
    ) -> [SwiftFile] {
        var url = workingDirectory
        
        if let folder = folder, !folder.isEmpty {
            if isSingleFolderName(folder: folder) {
                return self(
                    folders: folders(named: folder, in: workingDirectory),
                    inclusions: inclusions,
                    exclusions: exclusions
                )
            }
            
            url = workingDirectory.appendingPathComponent(folder).standardized
        }
        
        return self(url: url, inclusions: inclusions, exclusions: exclusions)
    }
    
    private func callAsFunction(
        folders: [URL],
        inclusions: [String],
        exclusions: [String]
    ) -> [SwiftFile] {
        folders.flatMap { self(url: $0, inclusions: inclusions, exclusions: exclusions) }
    }
    
    private func callAsFunction(
        url: URL,
        inclusions: [String],
        exclusions: [String]
    ) -> [SwiftFile] {
        let files = FileManager.default.enumerator(
            at: url,
            includingPropertiesForKeys: nil,
            options: [.skipsHiddenFiles]
        )?
        .compactMap { $0 as? URL }
        .filter { isSwiftFile(path: $0) }
        .filter {
            allowingInclusionOfFile(
                file: $0,
                basePath: url,
                inclusions: inclusions,
                exclusions: exclusions
            )
        }
        .compactMap(makeAsSwiftFile) ?? []

        return files
    }
    
    // We need to check if the target folder is a single folder or a compound path ("Path/To/Something").
    // If it's a Single Folder (e.g: "ViewModels"), it's important for Harmonize to lookup the whole project
    // and find every package/module named "ViewModels".
    private func isSingleFolderName(folder: String) -> Bool {
        if folder.isEmpty {
            return false
        }
        
        let components = folder.components(separatedBy: "/").filter { !$0.isEmpty }
        
        return components.count == 1
    }
    
    private func isSwiftFile(path: URL) -> Bool {
        !path.hasDirectoryPath && path.pathExtension == "swift"
    }
    
    private func makeAsSwiftFile(path: URL) -> SwiftFile? {
        try? SwiftFile(url: path)
    }
    
    private func allowingInclusionOfFile(
        file: URL,
        basePath: URL,
        inclusions: [String],
        exclusions: [String]
    ) -> Bool {
        let parentUrlString = file.absoluteString.replacingOccurrences(of: basePath.absoluteString, with: "")
        let parentUrl = URL(fileURLWithPath: parentUrlString)
        
        func fileOrParentIsContainedInArray(array: [String]) -> Bool {
            array.contains { element in
                if element.hasSuffix(".swift") {
                    return element == file.lastPathComponent
                }
                
                return parentUrl.pathComponents.contains { $0.hasSuffix(element) }
            }
        }
        
        if !inclusions.isEmpty {
            return fileOrParentIsContainedInArray(array: inclusions)
        }
        
        return !fileOrParentIsContainedInArray(array: exclusions)
    }
    
    private func folders(named folderName: String, in directory: URL) -> [URL] {
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
                if url.lastPathComponent == folderName {
                    folders.append(url)
                    enumerator.skipDescendants()
                }
            }
        }
        
        return folders
    }
}
