//
//  Extensions.swift
//
//
//  Created by Lucas Cavalcante on 9/5/24.
//

import Foundation

fileprivate extension Properties {
    func mergeThemAll() -> String {
        example2 + example3 + example9
    }
    
    convenience init(param: String) {
        self.init()
    }
}

extension Role: CaseIterable {
    public static var allCases: [Role] {
        [.noop(""), .pump("")]
    }
}
