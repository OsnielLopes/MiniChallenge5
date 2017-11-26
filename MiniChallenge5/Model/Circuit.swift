//
//  Circuit.swift
//  MiniChallenge5
//
//  Created by Renan Soares Germano on 26/11/17.
//  Copyright © 2017 Osniel Lopes Teixeira. All rights reserved.
//

import Foundation

struct Circuit: Codable{
    //MARK: Properties
    var id: Int?
    var points: [Point] = [Point]()
    
    //MARK: Types
    enum CodingKeys: String, CodingKey {
        case id
    }
    
    //MARK: Initializers
    init(id: Int?) {
        self.id = id
    }
    
    //MARK: Encode and Decode functions
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try values.decode(Int.self, forKey: .id)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
//        try container.encode(self.id, forKey: .id)
    }
}
