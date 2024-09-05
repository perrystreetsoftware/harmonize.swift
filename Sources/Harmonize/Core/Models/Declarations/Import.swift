//
//  Import.swift
//
//
//  Created by Lucas Cavalcante on 9/5/24.
//

import Foundation

public protocol Import: Declaration,
                        NamedDeclaration,
                        FileSourceProviding,
                        AttributesProviding {
    var kind: ImportKind { get }
}
