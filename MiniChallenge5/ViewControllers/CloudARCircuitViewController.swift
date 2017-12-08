//
//  CloudARCircuitViewController.swift
//  MiniChallenge5
//
//  Created by Osniel Lopes Teixeira on 07/12/2017.
//  Copyright © 2017 Osniel Lopes Teixeira. All rights reserved.
//

import UIKit
import MapKit
import SceneKit

class CloudARCircuitViewController: UIViewController, CircuitARSCNViewDelegate {
    
    let circuitDataManager = CircuitDataManager()
    let playDataManager = PlayDataManager()
    var circuit: Circuit!
    var scnView: SCNView!
    
    override func viewDidLoad() {
        if let delegate =  UIApplication.shared.delegate as? AppDelegate{
            if delegate.circuit != nil {
                self.circuit = delegate.circuit
            }
        }
        super.viewDidLoad()
        self.scnView = CloudCircuitARSCNView(frame: self.view.frame, circuit: circuit)
        self.view = scnView
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? RankingTableViewController{
            destination.isLocalRanking = false
        }
    }
    
    func didEndCircuit(seconds: UInt8, milliseconds: UInt8) {
        playDataManager.readByCircuit(circuitID: circuit.id!) { (plays) in
            for p in plays {
                CloudRanking.add(p)
            }
        }
        CloudRanking.add(Play(id: nil, circuitID: circuit.id!, player: (Session.shared?.player)!, seconds: Int(seconds), milliseconds: Int(milliseconds)))
        self.performSegue(withIdentifier: "toRankingFromCloudCircuit", sender: "nil")
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
