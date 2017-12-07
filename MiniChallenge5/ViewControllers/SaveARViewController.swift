//
//  LocalARCircuitViewController.swift
//  MiniChallenge5
//
//  Created by Osniel Lopes Teixeira on 01/12/2017.
//  Copyright © 2017 Osniel Lopes Teixeira. All rights reserved.
//

import UIKit
import MapKit

class SaveARViewController: UIViewController, CircuitARSCNViewDelegate {
    
    var arSceneView: SavableCircuitARSCNView!
    var locationManager: CLLocationManager = CLLocationManager()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = SavableCircuitARSCNView(frame: self.view.frame, locationManager: locationManager)
        arSceneView = self.view as! SavableCircuitARSCNView!
        arSceneView.circuitDelegate = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.checkLocationAuthorizationStatus()
        locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        locationManager.startUpdatingHeading()
        locationManager.startUpdatingLocation()
        arSceneView.circuitWillAppear()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func didEndCircuit(seconds: UInt8, milliseconds: UInt8) {
        let circuitDataManager = CircuitDataManager()
        circuitDataManager.create(circuit: arSceneView.circuit!) { (c) in
            return
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? RankingTableViewController{
            destination.isLocalRanking = true
        }
    }
    
    func checkLocationAuthorizationStatus() {
        if !(CLLocationManager.authorizationStatus() == .authorizedWhenInUse) {
            locationManager.requestWhenInUseAuthorization()
        }
    }
    
    
}
