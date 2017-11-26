//
//  Player.swift
//  MiniChallenge5
//
//  Created by Renan Soares Germano on 25/11/17.
//  Copyright © 2017 Osniel Lopes Teixeira. All rights reserved.
//

import Foundation

struct Player: Codable{
    var id: Int?
    var name: String
    var email: String
    var password: String
    var faction: Faction
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case email
        case password
        case faction = "faction_id"
    }
    
    init(id: Int?, name: String, email: String, password: String, faction: Faction) {
        self.id = id
        self.name = name
        self.email = email
        self.password = password
        self.faction = faction
    }
    
    init(from decoder: Decoder) throws {
        print("Starting decoder init")
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try values.decode(Int.self, forKey: .id)
        self.name = try values.decode(String.self, forKey: .name)
        self.email = try values.decode(String.self, forKey: .email)
        self.password = try values.decode(String.self, forKey: .password)
        let factionId: Int = try values.decode(Int.self, forKey: .faction)
        self.faction = Faction(id: factionId, name: "\(factionId)")
        print("Ending decoder init")
    }
    
    func encode(to encoder: Encoder) throws {
        print("Starting encoding")
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.name, forKey: .name)
        try container.encode(self.email, forKey: .email)
        try container.encode(self.password, forKey: .password)
        try container.encode(self.faction.id, forKey: .faction)
        print("Ending encoding")
    }
    
    
}
