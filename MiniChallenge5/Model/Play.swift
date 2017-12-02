//
//  Move.swift
//  MiniChallenge5
//
//  Created by Renan Soares Germano on 30/11/17.
//  Copyright © 2017 Osniel Lopes Teixeira. All rights reserved.
//

import Foundation

struct Move: Codable{
    var player: Player
    var circuit: Circuit
    var time: Int
}
