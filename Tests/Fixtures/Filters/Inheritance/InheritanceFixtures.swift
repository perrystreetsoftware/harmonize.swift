//
//  InheritanceFixtures.swift
//
//
//  Copyright (c) Perry Street Software 2024. All Rights Reserved.
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
