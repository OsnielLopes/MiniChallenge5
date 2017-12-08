//
//  LocalCircuitARSCNView.swift
//  MiniChallenge5
//
//  Created by Osniel Lopes Teixeira on 02/12/2017.
//  Copyright © 2017 Osniel Lopes Teixeira. All rights reserved.
//

import Foundation
import ARKit
import MapKit

class SavableCircuitARSCNView: CircuitARSCNView, CLLocationManagerDelegate{
    
    var locationManager:CLLocationManager!
    
    init(frame: CGRect, locationManager: CLLocationManager) {
        super.init(frame: frame)
        self.locationManager = locationManager
        locationManager.delegate = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let location = touches.first!.location(in: self)
        let existingPlaneResult = self.hitTest(location, types: .existingPlane)
        let estimatedHotizontalResult = self.hitTest(location, types: .estimatedHorizontalPlane)
        
        var results: [ARHitTestResult]!
        if existingPlaneResult.count == 0 {
            results = estimatedHotizontalResult
        } else {
            results = existingPlaneResult
        }
        
        //takes the farthest real word point finded
        if let closestResult = results.last {
            
            let matrix = SCNMatrix4(closestResult.worldTransform)

            
            //creates a indentity matriz that translates the point 1.5 meter up
            let translate = simd_float4x4(SCNMatrix4Translate(matrix, 0, 1.5, 0))
            
            let anchor = ARBowAnchor(transform: translate)
            bows.append(anchor)
            
            self.session.add(anchor: anchor)
        }
    }
    
    //MARK: ARSCNSceneDelegate
    
    override func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        super.renderer(renderer, didAdd: node, for: anchor)
        if anchor.isKind(of: ARBowAnchor.self){
            circuit.bows.append(Bow(worldTransform: anchor.transform.toFloatMatrix()))
        }
        
    }
    
    override func renderer(_ renderer: SCNSceneRenderer, updateAtTime time: TimeInterval) {
        print("Circuit = \(circuit != nil), endCircuit? \(self.didEndCircuit()), bows = \(self.bows.count)")
        if circuit != nil && self.didEndCircuit() && self.bows.count >= 2{
            DispatchQueue.main.async {
                if let appDelegate = UIApplication.shared.delegate as? AppDelegate{
                    appDelegate.circuit = self.circuit
                }
            }
            
        }
        super.renderer(renderer, updateAtTime: time)
    }

    //MARK: CLLocationManagerDelegate
    func locationManager(_ manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
        if circuit == nil {
            let location = Location(accuracy: (self.locationManager.location?.horizontalAccuracy)!,
                                magneticHeading: (self.locationManager.heading?.magneticHeading)!,
                                latitude: (self.locationManager.location?.coordinate.latitude)!,
                                longitude: (self.locationManager.location?.coordinate.longitude)!)
        circuit = Circuit(location: location)
        }

    }
    
    
}

