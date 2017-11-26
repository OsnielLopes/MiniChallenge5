//
//  ARCircleAnchor.swift
//  MiniChallenge5
//
//  Created by Osniel Lopes Teixeira on 21/11/2017.
//  Copyright © 2017 Osniel Lopes Teixeira. All rights reserved.
//

import ARKit

class ARBowAnchor: ARAnchor {
    
    var didPass: Bool = false
    var isNext: Bool = false
    
    override init(transform matrix: matrix_float4x4) {
        super.init(transform: matrix)
    }
    
    func pass(){
        didPass = true
    }
    
    func distance(from camera: ARCamera) -> Float{
        return simd_distance(matrix_float4x4(self.transform).columns.3, camera.transform.columns.3)
    }
}
