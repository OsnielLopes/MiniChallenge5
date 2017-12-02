//
//  Faction.swift
//  MiniChallenge5
//
//  Created by Renan Soares Germano on 25/11/17.
//  Copyright © 2017 Osniel Lopes Teixeira. All rights reserved.
//

import Foundation

struct Faction: Codable{
    //MARK: Properties
    var id: Int?
    var name: String
    
    init(id: Int?, name: String) {
        self.id = id
        self.name = name
    }
}
