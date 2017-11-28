//
//  File.swift
//  MiniChallenge5
//
//  Created by Osniel Lopes Teixeira on 26/11/2017.
//  Copyright © 2017 Osniel Lopes Teixeira. All rights reserved.
//

import Foundation

class Ranking {
    
    private static var plays = [Aplay]()
    
    class func add(_ play: Aplay){
        if plays.count == 0{
            plays.append(play)
        } else{
            for i in stride(from: plays.count-1, to: -1, by: -1){
                if plays[i].seconds <= play.seconds {
                    if plays[i].fraction < play.fraction {
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
    
    class func getPlays() -> [Aplay]{
        return plays
    }
    
    class func getPlayAtIndex(_ i: Int) -> Aplay {
        return plays[i]
    }
    
}
