//
//  File.swift
//  MiniChallenge5
//
//  Created by Osniel Lopes Teixeira on 26/11/2017.
//  Copyright © 2017 Osniel Lopes Teixeira. All rights reserved.
//

import Foundation

class Ranking {
    
    private static var plays = [Play]()
    
    class func add(_ play: Play){
        if plays.count == 0{
            plays.append(play)
        } else{
            for i in stride(from: plays.count-1, to: -1, by: -1){
                if plays[i].seconds <= play.seconds {
                    if plays[i].milliseconds < play.milliseconds {
                        plays.insert(play, at: i+1)
                    } else {
                        plays.insert(play, at: i)
                    }
                    break
                } else if i == 0 {
                    plays.insert(play, at: 0)
                }
            }
        }
        
    }
    
    class func getPlays() -> [Play]{
        return plays
    }
    
    class func getPlayAtIndex(_ i: Int) -> Play {
        return plays[i]
    }
    
}
