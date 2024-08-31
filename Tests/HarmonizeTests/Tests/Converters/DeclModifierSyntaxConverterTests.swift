import Foundation
@testable import Harmonize
import XCTest
import SwiftSyntax
import SwiftParser

final class DeclModifierSyntaxConverterTests: XCTestCase {
    private let visitor = ConvertersVisitor(viewMode: .sourceAccurate)
    private var modifiers: [Modifier] {
        visitor.modifiers
    }
    
    func testCanParseSwiftModifiers() throws {
        walk()
        
        XCTAssertEqual(visitor.modifiers.count, 26)
        XCTAssertEqual(
            modifiers,
            [
                .internal,
                .distributed,
                .open,
                .package,
                .override,
                .public,
                .lazy,
                .convenience,
                .private,
                .final,
                .dynamic,
                .fileprivate,
                .static,
                .privateSet,
                .weak,
                .unowned,
                .required,
                .optional,
                .internal,
                .indirect,
                .mutating,
                .nonmutating,
                .static,
                .prefix,
                .static,
                .postfix
            ]
        )
    }
    
    private func walk() {
        let sourceFile = Parser.parse(source: sourceCode)
        visitor.walk(sourceFile)
    }
}

private var sourceCode = """
internal protocol Collection {
    // unsupported
    __consuming func prefix(upTo end: Int) -> Int
}

distributed actor Actor {
    func present() -> Int { 42 }
    
    func bag(f: isolated Actor) async -> Int {
        42 * f.present()
    }
}

open class Engine {
    func power() {}
}

class EA888: Engine {
    package var package: String { "42" }
    
    override func power() {
        
    }
}

public class Vehicle {
    var speed: Int = 0
    
    lazy var engine: Int = { 42 }()
    
    init(value: Int) {
        self.speed = value
    }
    
    convenience init() {
        self.init()
    }
}

func borrow(_ account: borrowing Actor) {
}

private final class Diamond {
    dynamic var value: Int = 0
}

fileprivate class FBI {
    static var IntValue = 42
    
    private(set) var value: Int = 0
    
    weak var fbi: FBI?
    
    unowned var fbiU: FBI?
    
    required init() {}
}

@objc protocol Applicable {
    @objc optional func optionalMethod()
}

internal indirect enum Example {
    case value(Int)
    case next(Example)
    
    mutating func update() {
        
    }
    
    nonmutating func noop() {
        
    }
}

infix operator ** : MultiplicationPrecedence

func **(base: Int, power: Int) -> Int {
    return Int(pow(Double(base), Double(power)))
}

struct Counter {
    var count: Int
}

extension Counter {
    static prefix func ++ (counter:  Counter) -> Counter {
        counter.count += 1
        return counter
    }
    
    static postfix func ++ (counter:  Counter) -> Counter {
        counter.count += 1
        return counter
    }
}

"""
