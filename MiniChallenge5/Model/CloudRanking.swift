//
//  CloudRanking.swift
//  MiniChallenge5
//
//  Created by Osniel Lopes Teixeira on 06/12/2017.
//  Copyright © 2017 Osniel Lopes Teixeira. All rights reserved.
//

import Foundation

class CloudRanking: Ranking {
    
    private static var plays = [Play]()
    
    static func add(_ play: Play) {
        //
    }
    
    static func getPlays() -> [Play] {
        return plays
    }
    
    static func getPlayAtIndex(_ i: Int) -> Play {
        return plays.first!
    }
    
    
}
