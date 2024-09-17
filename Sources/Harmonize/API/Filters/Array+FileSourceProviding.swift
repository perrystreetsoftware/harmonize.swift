//
//  Array+FileSourceProviding.swift
//
//
//  Created by Lucas Cavalcante on 9/17/24.
//

import Foundation

public extension Array where Element: FileSourceProviding {
    func withFileSource(
        _ predicate: ((fileName: String, filePath: URL)) -> Bool
    ) -> [Element] {
        filter { predicate(($0.fileName, $0.filePath)) }
    }
}
