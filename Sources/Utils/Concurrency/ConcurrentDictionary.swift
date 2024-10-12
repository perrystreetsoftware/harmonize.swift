//
//  ConcurrentDictionary.swift
//  Harmonize
//
//  Copyright (c) Perry Street Software 2024. All Rights Reserved.
//

import Foundation

/// A thread-safe, generic dictionary that allows concurrent read and write operations.
///
/// The dictionary uses a `DispatchQueue` with a barrier for writes, ensuring that data
/// integrity is maintained during concurrent access.
///
public class ConcurrentDictionary<Key: Hashable, Value> {
    private var elements: [Key: Value] = [:]
    private let queue = DispatchQueue(label: "harmonize.concurrentdic.queue", attributes: .concurrent)
    
    public init() {}
    
    /// Accesses the value associated with the given key.
    ///
    /// - parameter key: The key to look up in the dictionary.
    /// - returns: The value associated with the key, or nil if value is not present.
    public subscript(key: Key) -> Value? {
        get { getValue(key: key) }
        set { setValue(key: key, value: newValue) }
    }
    
    // Removes the given key and its value from the dictionary.
    public func removeValue(forKey key: Key) -> Value? {
        return queue.sync {
            elements.removeValue(forKey: key)
        }
    }
    
    // Removes all elements from the dictionary.
    public func removeAll() {
        queue.async(flags: .barrier) {
            self.elements.removeAll()
        }
    }
    
    private func getValue(key: Key) -> Value? {
        queue.sync {
            elements[key]
        }
    }
    
    private func setValue(key: Key, value: Value?) {
        queue.async(flags: .barrier) {
            self.elements[key] = value
        }
    }
}
