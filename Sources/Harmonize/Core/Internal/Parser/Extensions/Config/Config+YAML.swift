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
    
    init(file: StaticString) {
        let configFilePath = try! URLResolver.resolveConfigFilePath(file)
        let content = try! String(contentsOfFile: configFilePath.path)
        try! self.init(content)
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        let excludes = try? values.decode([String].self, forKey: .excludes)
        
        excludePaths = excludes ?? []
    }
    
    public init(_ yaml: String) throws {
        guard !yaml.isEmpty else {
            excludePaths = []
            return
        }
        
        let decoded = try YAMLDecoder().decode(Self.self, from: yaml)
        excludePaths = decoded.excludePaths
    }
}
