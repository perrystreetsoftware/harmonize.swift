import Foundation

public protocol FileSourceProviding {
    /// The original swift file the declaration belongs to.
    var swiftFile: SwiftFile { get }
}

public extension FileSourceProviding {
    /// The file's name the declaration belongs to.
    var fileName: String {
        swiftFile.fileName
    }
    
    /// URL path of the declaration's file.
    var filePath: URL {
        swiftFile.filePath
    }
}
