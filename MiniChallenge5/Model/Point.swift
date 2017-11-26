//
//  Point.swift
//  MiniChallenge5
//
//  Created by Renan Soares Germano on 26/11/17.
//  Copyright © 2017 Osniel Lopes Teixeira. All rights reserved.
//

import Foundation

struct Point: Codable{
    //MARK: Properties
    var id: Int?
    var latitude: Double
    var longitude: Double
    var circuit: Circuit?
    
    //MARK: Types
    enum CodingKeys: String, CodingKey {
        case id
        case latitude
        case longitude
        case circuit = "circuit_id"
    }
    
    //MARK: Initializers
    init(id: Int?, latitude: Double, longitude: Double, circuit: Circuit?) {
        self.id = id
        self.latitude = latitude
        self.longitude = longitude
        self.circuit = circuit
    }
    
    //MARK: Encode and Decode functions
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try values.decode(Int.self, forKey: .id)
        self.latitude = try values.decode(Double.self, forKey: .latitude)
        self.longitude = try values.decode(Double.self, forKey: .longitude)
        let circuitId = try values.decode(Int.self, forKey: .circuit)
        self.circuit = Circuit(id: circuitId)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.id, forKey: .id)
        try container.encode(self.latitude, forKey: .latitude)
        try container.encode(self.longitude, forKey: .longitude)
        try container.encode(self.circuit?.id, forKey: .circuit)
    }
}
