//
//  Move.swift
//  MiniChallenge5
//
//  Created by Renan Soares Germano on 30/11/17.
//  Copyright © 2017 Osniel Lopes Teixeira. All rights reserved.
//

import Foundation

struct Play: Codable{
    //MARK: Properties
    var id: Int?
    var circuitID: Int?
    var player: Player
    var seconds: Int
    var milliseconds: Int
    
    //MARK: Types
    enum CodingKeys: String, CodingKey {
        case id
        case circuitID = "circuit_id"
        case playerID = "player_id"
        case player
        case seconds
        case milliseconds
    }
    
    //MARK: Initializers
    init(id: Int?, circuitID: Int, player: Player, seconds: Int, milliseconds: Int) {
        self.id = id
        self.circuitID = circuitID
        self.player = player
        self.seconds = seconds
        self.milliseconds = milliseconds
    }
    
    init(player: Player, seconds: Int, milliseconds: Int) {
        self.player = player
        self.seconds = seconds
        self.milliseconds = milliseconds
        self.id = nil
        self.circuitID = nil
    }
    
    //MARK: Encode and Decode functions
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try values.decode(Int.self, forKey: .id)
        self.circuitID = try values.decode(Int.self, forKey: .circuitID)
        self.player = try values.decode(Player.self, forKey: .player)
        self.seconds = try values.decode(Int.self, forKey: .seconds)
        self.milliseconds = try values.decode(Int.self, forKey: .milliseconds)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.circuitID, forKey: .circuitID)
        try container.encode(self.player.id, forKey: .playerID)
        try container.encode(self.seconds, forKey: .seconds)
        try container.encode(self.milliseconds, forKey: .milliseconds)
    }
}
