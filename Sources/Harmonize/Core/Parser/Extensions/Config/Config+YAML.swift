//
//  Config+YAML.swift
//
//
//  Created by Lucas Cavalcante on 9/7/24.
//

import Foundation
import Yams

extension Config: Decodable {
    private enum CodingKeys: String, CodingKey {
        case includes
        case excludes
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        let includes = try? values.decode([String].self, forKey: .includes)
        let excludes = try? values.decode([String].self, forKey: .excludes)
        
        includePaths = includes ?? []
        excludePaths = excludes ?? []
    }
    
    public init(_ yaml: String) throws {
        guard !yaml.isEmpty else {
            includePaths = []
            excludePaths = []
            return
        }
        
        let decoded = try YAMLDecoder().decode(Self.self, from: yaml)
        includePaths = decoded.includePaths
        excludePaths = decoded.excludePaths
    }
}
