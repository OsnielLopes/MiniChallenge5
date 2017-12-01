//
//  CircuitARSCNView.swift
//  MiniChallenge5
//
//  Created by Osniel Lopes Teixeira on 29/11/2017.
//  Copyright © 2017 Osniel Lopes Teixeira. All rights reserved.
//

import Foundation
import ARKit

class CircuitARSCNView: ARSCNView {
    
    var time = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 20))
    var bow = SCNNode()
    var bows = [ARBowAnchor]()
    var purpleGeometry = SCNTorus(ringRadius: 0.3, pipeRadius: 0.07)
    var pinkGeometry = SCNTorus(ringRadius: 0.3, pipeRadius: 0.07)
    var passage: Int = 0
    var startTime = TimeInterval()
    var isTimeCounting = false
    weak var delegate: CircuitARSCNViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.delegate = self
        self.antialiasingMode = .multisampling4X
        self.autoenablesDefaultLighting = true
        self.scene = SCNScene()
        
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = .horizontal
        self.session.run(configuration)
        
        //add the label for the chronometer
        self.addSubview(time)
        let centerXConstraint = NSLayoutConstraint(item: time, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 100)
        let centerYConstraint = NSLayoutConstraint(item: time, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1, constant: -150)
        //configure the bow node
        self.bow.eulerAngles.x = Float.pi/2
        
        //set up geometries
        purpleGeometry.firstMaterial?.diffuse.contents = UIColor.init(red: 89/255, green: 53/255, blue: 182/255, alpha: 1)
        pinkGeometry.firstMaterial?.diffuse.contents = UIColor.init(red: 237/255, green: 85/255, blue: 123/255, alpha: 1)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func circuitWillAppear() {
        for bow in bows{
            bow.didPass = false
        }
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

    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        if anchor.isKind(of: ARPlaneAnchor.self){
            // Place content only for anchors found by plane detection.
            guard let planeAnchor = anchor as? ARPlaneAnchor else { return }
            
            // Create a SceneKit plane to visualize the plane anchor using its position and extent.
            let plane = SCNPlane(width: CGFloat(planeAnchor.extent.x), height: CGFloat(planeAnchor.extent.z))
            plane.firstMaterial?.diffuse.contents = UIColor(red: 235/255, green: 223/255, blue: 49/255, alpha: 1)
            let planeNode = SCNNode(geometry: plane)
            planeNode.simdPosition = float3(planeAnchor.center.x, 0, planeAnchor.center.z)
            
            /*
             `SCNPlane` is vertically oriented in its local coordinate space, so
             rotate the plane to match the horizontal orientation of `ARPlaneAnchor`.
             */
            planeNode.eulerAngles.x = -.pi / 2
            
            // Make the plane visualization semitransparent to clearly show real-world placement.
            planeNode.opacity = 0.5
            
            /*
             Add the plane visualization to the ARKit-managed node so that it tracks
             changes in the plane anchor as plane estimation continues.
             */
            node.addChildNode(planeNode)
        }
    }

    func renderer(_ renderer: SCNSceneRenderer, updateAtTime time: TimeInterval) {
        
        var seconds: UInt8!
        var fraction: UInt8!
        
        if isTimeCounting
        {
            var elapsedTime: TimeInterval = time - startTime
            seconds = UInt8(elapsedTime)
            elapsedTime -= TimeInterval(seconds)
            
            fraction = UInt8(elapsedTime * 100)
            
            //add the leading zero for minutes, seconds and millseconds and store them as string constants
            let strSeconds = String(format: "%03d", seconds)
            let strFraction = String(format: "%02d", fraction)
            
            //concatenate minuets, seconds and milliseconds as assign it to the UILabel
            DispatchQueue.main.async {
                self.time.text = "\(strSeconds):\(strFraction)"
            }
        }
        
        if let currentFrame = self.session.currentFrame{
            if bows.count > 0 && !didEndCircuit() {
                
                var closerBow: ARBowAnchor?
                for bowAnchor in bows{
                    if closerBow == nil && bowAnchor.didPass{
                        continue
                    }
                    if closerBow == nil && !bowAnchor.didPass{
                        closerBow = bowAnchor
                    } else if bowAnchor.distance(from: currentFrame.camera) < (closerBow?.distance(from: currentFrame.camera))!
                        && !bowAnchor.didPass{
                        closerBow = bowAnchor
                    }
                }
                
                for bowAnchor in bows {
                    if bowAnchor != closerBow{
                        self.node(for: bowAnchor)?.childNodes[0].geometry = purpleGeometry
                    }
                }
                
                self.node(for: closerBow!)?.childNodes[0].geometry = pinkGeometry
                
                let distance = closerBow?.distance(from: currentFrame.camera)
                
                if distance! < 0.2 {
                    
                    if passage == 7 {
                        if !isTimeCounting {
                            isTimeCounting = true
                            startTime = time
                        }
                        AudioServicesPlayAlertSound(kSystemSoundID_Vibrate)
                        passage = 0
                        closerBow?.pass()
                        if didEndCircuit(){
                            isTimeCounting = false
                            startTime = TimeInterval()
                            delegate?.didEndCircuit(seconds: seconds, fraction: fraction)
                        }
                    } else {
                        passage += 1
                    }
                } else {
                    passage = 0
                    
                }
            }
        }
    }
    
    private func didEndCircuit() -> Bool{
        var didEnd: Bool = true
        for bow in bows {
            didEnd = didEnd && bow.didPass
        }
        return didEnd
    }
}
