//
//  File.swift
//  MiniChallenge5
//
//  Created by Osniel Lopes Teixeira on 26/11/2017.
//  Copyright © 2017 Osniel Lopes Teixeira. All rights reserved.
//

import Foundation

class LocalRanking: Ranking {
    

    private static var plays = [Play]()
    
    static func add(_ play: Play){
        plays.append(play)
        plays = plays.sorted { (a, b) -> Bool in
            return a.milliseconds < b.milliseconds && a.seconds < b.seconds
        }
        
    }
    
    static func getPlays() -> [Play]{
        return plays
    }
    
    static func getPlayAtIndex(_ i: Int) -> Play {
        return plays[i]
    }
    
}
