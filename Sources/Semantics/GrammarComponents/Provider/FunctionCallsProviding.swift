//
//  FunctionCallsProviding.swift
//  Harmonize
//
//  Copyright (c) Perry Street Software 2024. All Rights Reserved.
//

/// A protocol that represents declarations capable of providing a collection of invoked functions on its body.
public protocol FunctionCallsProviding {
    /// The list of function calls happening in this function, including calls from nested functions or closures.
    ///
    /// Given this function:
    ///
    /// ```swift
    /// func sampleCode() {
    ///     closure {
    ///         functionCall()
    ///     }
    ///
    ///     functionCall()
    /// }
    /// ```
    ///
    /// calling this will return: `["closure", "functionCall", "functionCall"]`.
    var functionCalls: [FunctionCall] { get }
}

public extension FunctionCallsProviding {
    /// Checks if any of the function calls matches a list of specified function names ignoring arguments and ().
    ///
    /// - Parameter functions: An array of function names to check.
    /// - Returns: A Boolean value indicating whether any of the functions in the list have been invoked.
    func invokes(_ functions: [String]) -> Bool {
        return functionCalls.contains(where: {
            functions.contains($0.call)
        })
    }

    /// Checks if a specific function name has been invoked.
    ///
    /// - Parameter function: The name of the function to check.
    /// - Returns: A Boolean value indicating whether the specified function has been invoked.
    func invokes(_ function: String) -> Bool {
        return invokes([function])
    }

    /// Checks if any function call satisfies a given predicate.
    ///
    /// - Parameter predicate: A closure that takes a `FunctionCall` object and returns a Boolean value.
    /// - Returns: A Boolean value indicating whether any function call satisfies the given predicate.
    func invokes(where predicate: (FunctionCall) -> Bool) -> Bool {
        return functionCalls.contains(where: predicate)
    }
}
