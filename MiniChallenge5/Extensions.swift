//
//  Extensions.swift
//  MiniChallenge5
//
//  Created by Osniel Lopes Teixeira on 07/11/2017.
//  Copyright © 2017 Osniel Lopes Teixeira. All rights reserved.
//

import Foundation
import MapKit

extension CLLocation {
    func toCoordinate() -> Coordinate {
        return Coordinate(latitude: self.coordinate.latitude, longitute: self.coordinate.longitude)
    }
}
