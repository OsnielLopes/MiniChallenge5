//
//  RankingProtocol.swift
//  MiniChallenge5
//
//  Created by Osniel Lopes Teixeira on 06/12/2017.
//  Copyright © 2017 Osniel Lopes Teixeira. All rights reserved.
//

import Foundation

protocol Ranking {
    static func add(_ play: Play)
    static func getPlays() -> [Play]
    static func getPlayAtIndex(_ i: Int) -> Play
}
