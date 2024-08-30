//
//  Functions.swift
//
//
//  Created by Lucas Cavalcante on 8/26/24.
//

import Foundation

func noArgLabelsFunction(_ p1: String, _ p2: String) {
    
}

func argLabelsFunction(p1: String, p2: String) {
    func nestedFunction() -> String {
        p1 + p2
    }
}

func customArgLabelsFunction(param1 p1: String, param2: String) {
    
}

func mixedLabeledArgsFunction(p1: String, _ p2: String) {
    
}

func variadic(args: String...) {
    
}

func noLabelVariadic(_ args: String...) {
    
}

func noLabelAtAll(_:String) {
}

func withReturnClause() -> String {
    let cal = "cal"
    noLabelAtAll(cal)
    return "return"
}

func withGenericVariance<T, R>(_ t: T, _ f: (T) -> R) -> R {
    f(t)
}

func withWhereClause<T>(_ t: T) -> Int where T: Sendable {
    42
}

func withParametersInitializers(param: String = "Value") -> Int {
    42
}

func withParametersAttributes(f: @autoclosure () -> Void) -> Int {
    f()
    return 42
}

public func fetchAllTheThings() async -> Int {
    return 42
}

private func privateFunc() {}
