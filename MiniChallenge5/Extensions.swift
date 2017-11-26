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
    func toCoordinate() -> Point {
        return Point(id: nil, latitude: self.coordinate.latitude, longitude: self.coordinate.longitude, circuit: nil)
    }
}

// Configura o design do text field
extension UITextField {
    func setBottomBorder() {
        self.borderStyle = .none
        self.layer.backgroundColor = UIColor(red: 43.0/255.0, green: 43.0/255.0, blue: 43.0/255.0, alpha: 0.7).cgColor
        
        
        
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor(red: 0.0/255.0, green: 0.0/255.0, blue: 0.0/255.0, alpha: 1).cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        self.layer.shadowOpacity = 1.0
        self.layer.shadowRadius = 0.0
    }
}
