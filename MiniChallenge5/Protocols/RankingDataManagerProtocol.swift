//
//  RankingDataManagerProtocol.swift
//  MiniChallenge5
//
//  Created by Osniel Lopes Teixeira on 28/11/2017.
//  Copyright © 2017 Osniel Lopes Teixeira. All rights reserved.
//

import Foundation

protocol RankingDataManagerProtocol {
    func getRanking(by circuitId:Int, callback: @escaping (_ ranking: Ranking)->() )
}
