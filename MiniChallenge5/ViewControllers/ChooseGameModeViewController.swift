//
//  ChooseGameModeViewController.swift
//  MiniChallenge5
//
//  Created by Osniel Lopes Teixeira on 05/12/2017.
//  Copyright © 2017 Osniel Lopes Teixeira. All rights reserved.
//

import UIKit
import MapKit

class ChooseGameModeViewController: UIViewController {

    @IBOutlet weak var playTheLocalCircuitButton: UIButton!
    let locationManager:CLLocationManager = CLLocationManager()
    let circuitManager:CircuitDataManager = CircuitDataManager()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        checkLocationAuthorizationStatus()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        //distanceFilter for the locationManager is not defined, keeping the default value
        locationManager.startUpdatingLocation()
        circuitManager.getCircuitLocations { (circuits) in
            circuits.first.
        }
    }
    

    func checkLocationAuthorizationStatus() {
        if !(CLLocationManager.authorizationStatus() == .authorizedWhenInUse) {
            locationManager.requestWhenInUseAuthorization()
        }
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
