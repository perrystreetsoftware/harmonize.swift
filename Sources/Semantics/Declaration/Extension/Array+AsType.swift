//
//  Array+AsType.swift
//  Harmonize
//
//  Copyright (c) Perry Street Software 2024. All Rights Reserved.
//

import Foundation

public extension Array where Element == Declaration {
    func `as`<T>(_:T.Type) -> [T] {
        compactMap { $0 as? T }
    }
}
