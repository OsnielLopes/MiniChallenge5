//
//  LocalARCircuitViewController.swift
//  MiniChallenge5
//
//  Created by Osniel Lopes Teixeira on 01/12/2017.
//  Copyright © 2017 Osniel Lopes Teixeira. All rights reserved.
//

import UIKit
import MapKit
import SceneKit

class SaveARViewController: UIViewController {
    
    var arSceneView: SavableCircuitARSCNView!
    var locationManager: CLLocationManager = CLLocationManager()
    var circuitDataManager = CircuitDataManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view = SavableCircuitARSCNView(frame: self.view.frame, locationManager: locationManager)
        arSceneView = self.view as! SavableCircuitARSCNView!
        arSceneView.circuitWillAppear()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.checkLocationAuthorizationStatus()
        locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        locationManager.startUpdatingHeading()
        locationManager.startUpdatingLocation()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
