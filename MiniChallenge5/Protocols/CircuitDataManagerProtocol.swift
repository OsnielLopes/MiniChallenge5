//
//  CircuitDataManagerProtocol.swift
//  MiniChallenge5
//
//  Created by Osniel Lopes Teixeira on 28/11/2017.
//  Copyright © 2017 Osniel Lopes Teixeira. All rights reserved.
//

import Foundation

protocol CircuitDataManagerProtocol {
    //MARK: Get the first location of all Circuits
    func getCircuitLocations(callback: @escaping (_ : [Bow]) -> ())
}
