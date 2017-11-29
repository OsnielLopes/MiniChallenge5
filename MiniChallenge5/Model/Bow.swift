//
//  Point.swift
//  MiniChallenge5
//
//  Created by Renan Soares Germano on 26/11/17.
//  Copyright © 2017 Osniel Lopes Teixeira. All rights reserved.
//

import Foundation

struct Bow: Codable{
    //MARK: Properties
    var latitude: Double
    var longitude: Double
    
    //MARK: initializers
    init(latitude: Double, longitude: Double) {
        self.latitude = latitude
        self.longitude = longitude
    }
}
