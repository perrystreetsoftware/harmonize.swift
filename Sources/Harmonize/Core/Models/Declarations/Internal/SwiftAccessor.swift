//
//  SwiftAccessor.swift
//
//
//  Created by Lucas Cavalcante on 8/25/24.
//

import Foundation

public struct SwiftAccessor: Equatable {
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
    
    public let modifier: Modifier
    
    public let body: String?
    
    public init(modifier: Modifier, body: String? = nil) {
        self.modifier = modifier
        self.body = body
    }
}
