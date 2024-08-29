//
//  SwiftAccessor.swift
//
//
//  Created by Lucas Cavalcante on 8/25/24.
//

import Foundation

public struct SwiftAccessor: SwiftDeclaration {
    public enum Modifier: String, CaseIterable, Equatable {
        case getter = "getter"
        case get = "get"
        case set = "set"
        case didSet = "didSet"
        case willSet = "willSet"
        
        public static func from(identifier: String) -> Modifier? {
            allCases.first { $0.rawValue == identifier }
        }
    }
    
    public let name: String
    
    public let text: String
    
    public let modifier: Modifier
    
    public let body: String
    
    public var parent: SwiftDeclaration?
    
    public var children = [SwiftDeclaration]()
}
