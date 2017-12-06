//
//  Session.swift
//  MiniChallenge5
//
//  Created by Renan Soares Germano on 05/12/17.
//  Copyright © 2017 Osniel Lopes Teixeira. All rights reserved.
//

import Foundation

struct Session: Codable{
    
    //MARK: Shared instance
    static var shared: Session? {
        willSet(session){
            if shared == nil {
                shared = session
            }
        }
    }
    
    //MARK: Properties
    var player: Player
    var token: String
    
    //MARK: Initializers
    init(player: Player, token: String) {
        self.player = player
        self.token = token
    }
    
    //MARK: Types
    enum CodingKeys: String, CodingKey {
        case player
        case token
    }
    
    //MARK: Encode and Decode functions
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.player = try values.decode(Player.self, forKey: .player)
        self.token = try values.decode(String.self, forKey: .token)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.player, forKey: .player)
        try container.encode(self.token, forKey: .token)
    }
    
}
