//
//  LocalARCircuitViewController.swift
//  MiniChallenge5
//
//  Created by Osniel Lopes Teixeira on 01/12/2017.
//  Copyright © 2017 Osniel Lopes Teixeira. All rights reserved.
//

import UIKit

class LocalARCircuitViewController: UIViewController, CircuitARSCNViewDelegate{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let arSceneView = self.view as? LocalCircuitARSCNView{
            arSceneView.circuitDelegate = self
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func didEndCircuit(seconds: UInt8, milliseconds: UInt8) {
        let message: String = "Digite seu nome:"
        let alert = UIAlertController(title: "Parabéns!", message: message, preferredStyle: .alert)
        DispatchQueue.main.async {
            alert.addAction(
                UIAlertAction(
                    title: NSLocalizedString("OK", comment: ""),
                    style: .default,
                    handler: { (action) in
                        let appDelegate = UIApplication.shared.delegate as! AppDelegate
                        let player = appDelegate.player
                        Ranking.add(Play(player: player!, seconds: Int(seconds), milliseconds: Int(milliseconds)))
                        self.performSegue(withIdentifier: "toRankingFromLocalCircuit", sender: self)
                }))
            alert.addTextField(configurationHandler: { (textField: UITextField! ) in
                textField.isSecureTextEntry = false
            })
            self.present(alert, animated: true, completion: nil)
        }
        
    }
    
    
}
