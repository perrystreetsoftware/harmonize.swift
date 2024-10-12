//
//  InheritanceFixtures.swift
//
//
//  Created by Lucas Cavalcante on 9/16/24.
//

import Foundation

protocol AgedUserModel {
    var age: Int { get }
}

struct UserModel: AgedUserModel {
    let name: String
    let age: Int
}

class BaseUseCase {}

class FetchUserUseCase: BaseUseCase {}
