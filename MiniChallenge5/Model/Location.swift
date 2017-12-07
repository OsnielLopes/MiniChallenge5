//
//  File.swift
//  MiniChallenge5
//
//  Created by Osniel Lopes Teixeira on 06/12/2017.
//  Copyright © 2017 Osniel Lopes Teixeira. All rights reserved.
//

import Foundation

struct Location: Codable {
    var acuraccy: Double
    var magneticHeading: Double
    var latitude: Double
    var longitude: Double
}
