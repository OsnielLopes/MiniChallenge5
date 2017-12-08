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

class CloudARCircuitViewController: UIViewController, CLLocationManagerDelegate {
    
    let circuitDataManager = CircuitDataManager()
    let locationManager = CLLocationManager()
    var id: Int!
    var circuit: Circuit!
    var scnView: SCNView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        if !self.view.isKind(of: SCNView.self){
        if abs(newHeading.magneticHeading - (circuit.location?.magneticHeading)!) < 10{
            if (locationManager.location?.distance(from: (circuit.location?.toCLLocation())!))! <
                Double((locationManager.location?.horizontalAccuracy)!) + Double((circuit.location?.accuracy)!) {
                let circuitScn = CloudCircuitARSCNView(frame: self.view.frame, circuit: circuit)
                self.view = circuitScn
            }
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
