//
//  Circuito.swift
//  MiniChallenge5
//
//  Created by Osniel Lopes Teixeira on 06/11/2017.
//  Copyright © 2017 Osniel Lopes Teixeira. All rights reserved.
//

import MapKit
import Foundation

struct Circuit: Codable {

    var coordinates: [Coordinate]

    enum CodingKeys: String, CodingKey{
        case coordinates = "circuit"
    }

//    func getCoordinates() -> [Coordinate] {
//        return self.coordinates
//    }
//
//    func addNewCoordinate(_ coordinate: Coordinate){
//        self.coordinates.append(coordinate)
//    }
//
//    func removeCoordinate(_ coordinate: Coordinate){
//        for i in 0..<coordinates.count {
//            if (coordinates[i] == coordinate){
//                coordinates.remove(at: i)
//                break
//            }
//        }
//    }
    
}

// TODO: deixar o atributo coordinates como privado e criar um iterator para permitir o acesso às coordenas
