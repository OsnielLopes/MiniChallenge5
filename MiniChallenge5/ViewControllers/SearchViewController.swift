//
//  SearchViewController.swift
//  MiniChallenge5
//
//  Created by Osniel Lopes Teixeira on 08/12/2017.
//  Copyright © 2017 Osniel Lopes Teixeira. All rights reserved.
//

import UIKit
import MapKit

class SearchViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var directionLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    let circuitDataManager = CircuitDataManager()
    let locationManager = CLLocationManager()
    var circuit: Circuit!
    var id: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        checkLocationAuthorizationStatus()
        locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        locationManager.startUpdatingHeading()
        locationManager.startUpdatingLocation()
        locationManager.delegate = self
        
        if let delegate =  UIApplication.shared.delegate as? AppDelegate{
            if delegate.circuit != nil {
                self.circuit = delegate.circuit
            } else if id != nil {
                circuitDataManager.readById(id: id, callback: { (circuit) in
                    self.circuit = circuit
                })
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func checkLocationAuthorizationStatus() {
        if !(CLLocationManager.authorizationStatus() == .authorizedWhenInUse) {
            locationManager.requestWhenInUseAuthorization()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
        let angleDistance = newHeading.magneticHeading - (circuit.location?.magneticHeading)!
        let metersDistance = Double((locationManager.location?.distance(from: (circuit.location?.toCLLocation())!))!)
        self.distanceLabel.text = "You are \(metersDistance) meters from the circuit."
        if angleDistance < -10 {
            self.directionLabel.text = "Turn \((angleDistance+10) * (-1)) degrees to the right."
        } else if angleDistance > 10 {
            self.directionLabel.text = "Turn \((angleDistance-10)) degrees to the left."
        } else {
            
                if metersDistance < Double((locationManager.location?.horizontalAccuracy)!) + Double((circuit.location?.acuraccy)!) {
                    self.performSegue(withIdentifier: "toCloudArCircuit", sender: nil)
                }
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
