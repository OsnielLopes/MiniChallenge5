//
//  File.swift
//  MiniChallenge5
//
//  Created by Osniel Lopes Teixeira on 26/11/2017.
//  Copyright © 2017 Osniel Lopes Teixeira. All rights reserved.
//

import Foundation

class Historic {
    
    private static var plays = [Aplay]()
    
    class func add(_ play: Aplay){
        if plays.count == 0{
            plays.append(play)
        } else {
            var lower = 0
            for i in 0..<plays.count{
                if plays[i].seconds < play.seconds && plays[i].fraction < play.fraction {
                    lower = i
                } else {
                    break
                }
            }
            plays.insert(play, at: lower+1)
        }
    }
    
    class func getPlays() -> [Aplay]{
        return plays
    }
    
    class func getPlayAtIndex(_ i: Int) -> Aplay {
        return plays[i]
    }
    
}
