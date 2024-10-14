//
//  String+LogicalOperators.swift
//  Harmonize
//
//  Copyright (c) Perry Street Software 2024. All Rights Reserved.
//

public extension String {
    /// Combines two `String` values into an array of `String` using the `||` operator.
    static func ||(lhs: String, rhs: String) -> [String] {
        [lhs, rhs]
    }
}

public extension Array where Element == String {
    /// Appends a `String` value to an array of `String` elements using the `||` operator.
    static func ||(lhs: [String], rhs: String) -> [String] {
        lhs + [rhs]
    }
}
