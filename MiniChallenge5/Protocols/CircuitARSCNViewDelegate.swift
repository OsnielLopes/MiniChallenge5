//
//  CircuitARSCNViewDelegate.swift
//  MiniChallenge5
//
//  Created by Osniel Lopes Teixeira on 29/11/2017.
//  Copyright © 2017 Osniel Lopes Teixeira. All rights reserved.
//

import Foundation

protocol CircuitARSCNViewDelegate {
    func didEndCircuit(seconds: UInt8, milliseconds: UInt8)
}
