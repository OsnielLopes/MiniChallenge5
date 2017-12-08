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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Coloca imagem e filtro no background da view
        let backgroundImage = UIImageView(frame: self.view.frame)
        let filterImage = UIImageView(frame: self.view.frame)
        
        backgroundImage.image = UIImage(named: "background_image")
        filterImage.image = UIImage(named: "filter")
        
        self.view.insertSubview(filterImage, at: 0)
        self.view.insertSubview(backgroundImage, at: 0)
        
        // Deixa a navigation bar transparente
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        
        // Deixa a navigation bar sem sombra
        navigationController?.navigationBar.shadowImage = UIImage()


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
        self.distanceLabel.text = NSString(format: "You are %.2f meters from the circuit.", metersDistance) as String
        if angleDistance < -10 {
            self.directionLabel.text = NSString(format: "Turn %.2f degrees to the right.", (angleDistance+10) * (-1)) as String
        } else if angleDistance > 10 {
            self.directionLabel.text = NSString(format: "Turn %.2f degrees to the left.", (angleDistance-10)) as String
        } else {
            
            if metersDistance < Double((locationManager.location?.horizontalAccuracy)!) + Double((circuit.location?.accuracy)!) {
                self.locationManager.delegate = nil
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
