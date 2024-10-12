//
//  AttributesFixtures.swift
//
//
//  Created by Lucas Cavalcante on 9/16/24.
//

import Foundation
import SwiftUI

class AttributesViewModel: ObservableObject {
    @Published var state: Int = 0
    @Published var name: String = ""
}
