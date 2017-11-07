//
//  Circuito.swift
//  MiniChallenge5
//
//  Created by Osniel Lopes Teixeira on 06/11/2017.
//  Copyright © 2017 Osniel Lopes Teixeira. All rights reserved.
//

import MapKit
import Foundation

class Circuito: Codable {

    private var coordinates: [Coordinate]!

    init (_ coordinates: [Coordinate]){
        self.coordinates = coordinates
    }

    func addNewCoordinate(_ coordinate: Coordinate){
        self.coordinates.append(coordinate)
    }
    
    func removeCoordinate(_ coordinate: Coordinate){
        for i in 0..<coordinates.count {
            if (coordinates[i] == coordinate){
                coordinates.remove(at: i)
                break
            }
        }
    }
    
}
