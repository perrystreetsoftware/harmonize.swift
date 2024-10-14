//
//  BodyProviding.swift
//  Harmonize
//
//  Copyright (c) Perry Street Software 2024. All Rights Reserved.
//

/// A protocol that represents declarations capable of providing a body.
public protocol BodyProviding {
    /// The body of the declaration as a `String`, if any.
    ///
    /// This property returns the body of the declaration, representing the code inside functions, initializers,
    /// or similar constructs. For example, in a function:
    ///
    /// ```swift
    /// func greet() {
    ///     print("Hello, World!")
    /// }
    /// ```
    /// The `body` is `"print(\"Hello, World!\")"`. If the declaration does not have a body, this returns `nil`.
    var body: String? { get }
}
