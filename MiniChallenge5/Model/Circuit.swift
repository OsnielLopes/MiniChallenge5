//
//  Circuit.swift
//  MiniChallenge5
//
//  Created by Renan Soares Germano on 26/11/17.
//  Copyright © 2017 Osniel Lopes Teixeira. All rights reserved.
//

import Foundation
import MapKit

class Circuit: Codable{
    //MARK: Properties
    var id: Int?
    var location: Location?
    var bows = [Bow]()
    
    init() {
        id = nil
    }
    
    init(location: Location) {
        self.location = location
    }
}
