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
}
