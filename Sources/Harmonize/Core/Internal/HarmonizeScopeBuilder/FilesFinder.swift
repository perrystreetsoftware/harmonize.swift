//
//  FilesFinder.swift
//
//
//  Created by Lucas Cavalcante on 9/9/24.
//

import Foundation

/// The internal implementation responsible for Swift File lookup through the source.
internal class FilesFinder {
    private let workingDirectory: URL
    private let config: Config

    init(_ file: StaticString) {
        self.workingDirectory = try! URLResolver.resolveProjectRootPath(file)
        self.config = Config(file: file)
    }
    
    internal func callAsFunction(
        folder: String?,
        inclusions: [String],
        exclusions: [String]
    ) -> [SwiftFile] {
        var url = workingDirectory
        
        if let folder = folder, !folder.isEmpty {
            url = workingDirectory.appendingPathComponent(folder).standardized
            
            if !pathExists(path: url.absoluteString) {
                return self(
                    folders: folders(containing: folder, in: workingDirectory),
                    inclusions: inclusions,
                    exclusions: exclusions
                )
            }
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
                exclusions: config.excludePaths + exclusions
            )
        }
        .compactMap(makeAsSwiftFile) ?? []

        return files
    }
    
    private func pathExists(path: String) -> Bool {
        var isDirectory: ObjCBool = false
        return FileManager.default.fileExists(
            atPath: path,
            isDirectory: &isDirectory
        ) && isDirectory.boolValue
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
    
    private func folders(containing pathComponent: String, in directory: URL) -> [URL] {
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
