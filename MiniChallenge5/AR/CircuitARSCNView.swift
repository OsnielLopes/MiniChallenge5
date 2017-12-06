//
//  CircuitARSCNView.swift
//  MiniChallenge5
//
//  Created by Osniel Lopes Teixeira on 29/11/2017.
//  Copyright © 2017 Osniel Lopes Teixeira. All rights reserved.
//

import Foundation
import ARKit

class CircuitARSCNView: ARSCNView, ARSCNViewDelegate {
    
    var time = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 20))
    var bow = SCNNode()
    var bows = [ARBowAnchor]()
    var purpleGeometry = SCNTorus(ringRadius: 0.3, pipeRadius: 0.07)
    var pinkGeometry = SCNTorus(ringRadius: 0.3, pipeRadius: 0.07)
    var passage: Int = 0
    var startTime = TimeInterval()
    var isTimeCounting = false
    var circuitDelegate: CircuitARSCNViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUp()
        print(self.frame.width)
    }
    
    func setUp(){
        self.antialiasingMode = .multisampling4X
        self.autoenablesDefaultLighting = true
        self.scene = SCNScene()
        
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = .horizontal
        self.delegate = self
        self.session.run(configuration)
        
        //add the label for the chronometer
        self.addSubview(time)

        time.text = "00:00"
        time.textColor = UIColor.white
        time.translatesAutoresizingMaskIntoConstraints = false
        time.centerXAnchor.constraint(equalTo: self.layoutMarginsGuide.rightAnchor, constant: -10).isActive = true
        time.centerYAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        
        
        self.bow.eulerAngles.x = Float.pi/2
        
        //set up geometries
        purpleGeometry.firstMaterial?.diffuse.contents = UIColor.init(red: 89/255, green: 53/255, blue: 182/255, alpha: 1)
        pinkGeometry.firstMaterial?.diffuse.contents = UIColor.init(red: 237/255, green: 85/255, blue: 123/255, alpha: 1)
    }
    
    func circuitWillAppear() {
        for bow in bows{
            bow.didPass = false
            node(for: bow)?.opacity = 1
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
        var milliseconds: UInt8!
        
        if isTimeCounting
        {
            var elapsedTime: TimeInterval = time - startTime
            seconds = UInt8(elapsedTime)
            elapsedTime -= TimeInterval(seconds)
            
            milliseconds = UInt8(elapsedTime * 100)
            
            //add the leading zero for minutes, seconds and millseconds and store them as string constants
            let strSeconds = String(format: "%02d", seconds)
            let strmilliseconds = String(format: "%02d", milliseconds)
            
            //concatenate minuets, seconds and milliseconds as assign it to the UILabel
            DispatchQueue.main.async {
                self.time.text = "\(strSeconds):\(strmilliseconds)"
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
                        if bowAnchor.didPass {
                            self.node(for: bowAnchor)?.opacity = 0.5
                        }
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
                            circuitDelegate?.didEndCircuit(seconds: seconds, milliseconds: milliseconds)
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
