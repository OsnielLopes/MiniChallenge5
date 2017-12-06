//
//  LocalARCircuitViewController.swift
//  MiniChallenge5
//
//  Created by Osniel Lopes Teixeira on 01/12/2017.
//  Copyright © 2017 Osniel Lopes Teixeira. All rights reserved.
//

import UIKit

class SaveARViewController: UIViewController, CircuitARSCNViewDelegate{
    
    var arSceneView: LocalCircuitARSCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        arSceneView = self.view as! LocalCircuitARSCNView
        arSceneView.circuitDelegate = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.tintColor = UIColor.white
        arSceneView.circuitWillAppear()
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
                        LocalRanking.add(Play(player: Player(name: alert.textFields![0].text!), seconds: Int(seconds), milliseconds: Int(milliseconds)))
                        self.performSegue(withIdentifier: "toRankingFromLocalCircuit", sender: nil)
                }))
            alert.addTextField(configurationHandler: { (textField: UITextField! ) in
                textField.isSecureTextEntry = false
            })
            self.present(alert, animated: true, completion: nil)
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? RankingTableViewController{
            destination.isLocalRanking = true
        }
    }
    
    
}
