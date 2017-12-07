//
//  File.swift
//  MiniChallenge5
//
//  Created by Osniel Lopes Teixeira on 06/12/2017.
//  Copyright © 2017 Osniel Lopes Teixeira. All rights reserved.
//

import Foundation
import MapKit

struct Location: Codable {
    var acuraccy: Double
    var magneticHeading: Double
    var latitude: Double
    var longitude: Double
    
    func toCLLocation() -> CLLocation{
       return CLLocation(latitude: latitude, longitude: longitude)
    }
}
