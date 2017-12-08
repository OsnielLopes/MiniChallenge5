//
//  Circuit.swift
//  MiniChallenge5
//
//  Created by Renan Soares Germano on 26/11/17.
//  Copyright © 2017 Osniel Lopes Teixeira. All rights reserved.
//

import Foundation
import MapKit

struct Circuit: Codable{
    //MARK: Properties
    var id: Int?
    var location: Location?
    var bows: [Bow]!
    
    //MARK: Types
    enum CodingKeys: String, CodingKey {
        case id
        case accuracy
        case magneticHeading = "magnetic_heading"
        case latitude
        case longitude
        case bows
    }
    
    //MARK: Initializers
    init(){
        self.id = nil
        self.location = nil
        self.bows = [Bow]()
    }
    
    init(location: Location?) {
        self.id = nil
        self.location = location
        self.bows = [Bow]()
    }
    
    //MARK: Encode and Decode functions
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try values.decode(Int.self, forKey: .id)
        let accuracy:Double  = try values.decode(Double.self, forKey: .accuracy)
        let magneticHeading: Double = try values.decode(Double.self, forKey: .magneticHeading)
        let latitude: Double = try values.decode(Double.self, forKey: .latitude)
        let longitude: Double = try values.decode(Double.self, forKey: .longitude)
        self.location = Location(accuracy: accuracy, magneticHeading: magneticHeading, latitude: latitude, longitude: longitude)
        self.bows = try values.decode([Bow].self, forKey: .bows)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.location?.accuracy, forKey: .accuracy)
        try container.encode(self.location?.magneticHeading, forKey: .magneticHeading)
        try container.encode(self.location?.latitude, forKey: .latitude)
        try container.encode(self.location?.longitude, forKey: .longitude)
        try container.encode(self.bows, forKey: .bows)
    }
}
