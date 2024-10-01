//
//  FilesFinder.swift
//
//
//  Created by Lucas Cavalcante on 9/9/24.
//

import Foundation

/// The internal implementation responsible for Swift File lookup through the source.
internal class FindSwiftFiles {
    private let workingDirectory: URL
    private let config: Config
    private let findParseableFolders: FindParseableFolders

    init(_ file: StaticString) {
        self.workingDirectory = try! ResolveProjectWorkingDirectory()(file)
        self.config = Config(file: file)
        self.findParseableFolders = FindParseableFolders()
    }
    
    init(_ workingDirectory: URL) {
        self.workingDirectory = workingDirectory
        self.config = Config(excludePaths: [])
        self.findParseableFolders = FindParseableFolders()
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
                return findSwiftFilesFromFolders(
                    folders: findParseableFolders(containing: folder, in: workingDirectory),
                    inclusions: inclusions,
                    exclusions: exclusions
                )
            }
        }
        
        return findSwiftFiles(url: url, inclusions: inclusions, exclusions: exclusions)
    }
    
    private func findSwiftFilesFromFolders(
        folders: [URL],
        inclusions: [String],
        exclusions: [String]
    ) -> [SwiftFile] {
        folders.flatMap {
            findSwiftFiles(url: $0, inclusions: inclusions, exclusions: exclusions)
        }
    }
    
    private func findSwiftFiles(
        url: URL,
        inclusions: [String],
        exclusions: [String]
    ) -> [SwiftFile] {
        let urls = FileManager.default.enumerator(
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
        } ?? []
        
        guard !urls.isEmpty else { return [] }
        
        var files = [SwiftFile]()
        
        DispatchQueue.concurrentPerform(iterations: urls.count) { index in
            if let file = try? SwiftFile(url: urls[index]) {
                files.append(file)
            }
        }

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
}
