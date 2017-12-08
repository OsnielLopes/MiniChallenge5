//
//  AutoCreateCircuitARSCNView.swift
//  MiniChallenge5
//
//  Created by Osniel Lopes Teixeira on 07/12/2017.
//  Copyright © 2017 Osniel Lopes Teixeira. All rights reserved.
//

import Foundation
import SceneKit

class CloudCircuitARSCNView: CircuitARSCNView {
    
    init(frame: CGRect, circuit: Circuit) {
        super.init(frame: frame)
        self.circuit = circuit
        createCircuit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        createCircuit()
    }
    
    func createCircuit() {
        for bow in circuit.bows{
            let bowAnchor = ARBowAnchor(transform: matrix_float4x4(float4(bow.worldTransform[0]), float4(bow.worldTransform[1]), float4(bow.worldTransform[2]), float4(bow.worldTransform[3])))
            print("----------aqui estou adicionando nodes do circuito---------------")
            bows.append(bowAnchor)
            self.session.add(anchor: bowAnchor)
        }
    }
    
}
