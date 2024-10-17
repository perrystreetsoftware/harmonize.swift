//
//  AttributesFixtures.swift
//
//
//  Copyright (c) Perry Street Software 2024. All Rights Reserved.
//

import Foundation
import SwiftUI

class AttributesViewModel: ObservableObject {
    @Published var state: Int = 0
    @Published var name: String = ""
}
