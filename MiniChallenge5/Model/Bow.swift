//
//  Point.swift
//  MiniChallenge5
//
//  Created by Renan Soares Germano on 26/11/17.
//  Copyright © 2017 Osniel Lopes Teixeira. All rights reserved.
//

import Foundation
import SceneKit

struct Bow: Codable{
    //MARK: Properties
    var worldTransform: [[Float]]!
    
    //MARK: Types
    enum CodingKeys: String, CodingKey {
        case m00
        case m01
        case m02
        case m03
        case m10
        case m11
        case m12
        case m13
        case m20
        case m21
        case m22
        case m23
        case m30
        case m31
        case m32
        case m33
    }
    
    //MARK: Initializers
    init(){}
    
    init(worldTransform: [[Float]]!){
        self.worldTransform = worldTransform
    }
    
    //MARK: Encode and Decode functions
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.worldTransform = [[Float]]()
        
        let m00: Float = try values.decode(Float.self, forKey: .m00)
        let m01: Float = try values.decode(Float.self, forKey: .m01)
        let m02: Float = try values.decode(Float.self, forKey: .m02)
        let m03: Float = try values.decode(Float.self, forKey: .m03)
        self.worldTransform.append([m00, m01, m02, m03])
        
        let m10: Float = try values.decode(Float.self, forKey: .m10)
        let m11: Float = try values.decode(Float.self, forKey: .m11)
        let m12: Float = try values.decode(Float.self, forKey: .m12)
        let m13: Float = try values.decode(Float.self, forKey: .m13)
        self.worldTransform.append([m10, m11, m12, m13])
        
        let m20: Float = try values.decode(Float.self, forKey: .m20)
        let m21: Float = try values.decode(Float.self, forKey: .m21)
        let m22: Float = try values.decode(Float.self, forKey: .m22)
        let m23: Float = try values.decode(Float.self, forKey: .m23)
        self.worldTransform.append([m20, m21, m22, m23])
        
        let m30: Float = try values.decode(Float.self, forKey: .m30)
        let m31: Float = try values.decode(Float.self, forKey: .m31)
        let m32: Float = try values.decode(Float.self, forKey: .m32)
        let m33: Float = try values.decode(Float.self, forKey: .m33)
        self.worldTransform.append([m30, m31, m32, m33])
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(self.worldTransform[0][0], forKey: .m00)
        try container.encode(self.worldTransform[0][1], forKey: .m01)
        try container.encode(self.worldTransform[0][2], forKey: .m02)
        try container.encode(self.worldTransform[0][3], forKey: .m03)
        
        try container.encode(self.worldTransform[1][0], forKey: .m10)
        try container.encode(self.worldTransform[1][1], forKey: .m11)
        try container.encode(self.worldTransform[1][2], forKey: .m12)
        try container.encode(self.worldTransform[1][3], forKey: .m13)
        
        
        try container.encode(self.worldTransform[2][0], forKey: .m20)
        try container.encode(self.worldTransform[2][1], forKey: .m21)
        try container.encode(self.worldTransform[2][2], forKey: .m22)
        try container.encode(self.worldTransform[2][3], forKey: .m23)
        
        try container.encode(self.worldTransform[3][0], forKey: .m30)
        try container.encode(self.worldTransform[3][1], forKey: .m31)
        try container.encode(self.worldTransform[3][2], forKey: .m32)
        try container.encode(self.worldTransform[3][3], forKey: .m33)
    }
    
}
