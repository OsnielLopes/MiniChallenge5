//
//  CircuitDataManagerProtocol.swift
//  MiniChallenge5
//
//  Created by Osniel Lopes Teixeira on 28/11/2017.
//  Copyright © 2017 Osniel Lopes Teixeira. All rights reserved.
//

import Foundation

protocol CircuitDataManagerProtocol {
    func getCircuitLocations(callback: @escaping (_ : [Bow]) -> ())
    func getCircuit(by id: Int, callback: @escaping (_ :Circuit)->())
}
