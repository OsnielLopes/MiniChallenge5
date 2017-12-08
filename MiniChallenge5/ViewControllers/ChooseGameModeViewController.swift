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
    //MARK: Constraints
    @IBOutlet weak var manRunningTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var playMyCircuitButtonTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var playLocalCircuitButtonTopConstraint: NSLayoutConstraint!
    
    
    //MARK: Outlets
    @IBOutlet weak var playMyCircuitButton: UIButton!
    @IBOutlet weak var playTheLocalCircuitButton: UIButton!
    
    //MARK: Properties
    let locationManager:CLLocationManager = CLLocationManager()
    let circuitManager:CircuitDataManager = CircuitDataManager()
    var closestCircuitId:Int?
    
    //MARK: Life cicle functions
    override func viewDidLoad() {
        
        //Coloca imagem e filtro no background da view
        let backgroundImage = UIImageView(frame: self.view.frame)
        let filterImage = UIImageView(frame: self.view.frame)
        
        backgroundImage.image = UIImage(named: "background_image")
        filterImage.image = UIImage(named: "filter")
        
        self.view.insertSubview(filterImage, at: 0)
        self.view.insertSubview(backgroundImage, at: 0)
        
        super.viewDidLoad()
        if !Reachability.isConnectedToNetwork(){
            playTheLocalCircuitButton.isEnabled = false
        }
        if closestCircuitId != nil || (UIApplication.shared.delegate as! AppDelegate).circuit != nil{
            playTheLocalCircuitButton.isEnabled = true
        } else {
            playTheLocalCircuitButton.isEnabled = false
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationController?.navigationBar.backgroundColor = nil
        
        // Definição de constraints
        manRunningTopConstraint.constant = self.view.frame.size.height * 0.149
        playMyCircuitButtonTopConstraint.constant = self.view.frame.size.height * 0.547
        playLocalCircuitButtonTopConstraint.constant = self.view.frame.size.height * 0.674

        
        checkLocationAuthorizationStatus()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
        
        circuitManager.getCircuitLocations { (circuits) in
            for (id, location) in circuits{
                let newLocation = CLLocation(latitude: CLLocationDegrees(location.latitude), longitude: CLLocationDegrees(location.longitude))
                if newLocation.distance(from: self.locationManager.location!) < location.accuracy + (self.locationManager.location?.horizontalAccuracy)! {
                    self.closestCircuitId = id
                    break
                }
            }
        }
        self.navigationController?.navigationBar.tintColor = UIColor.black
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if !Reachability.isConnectedToNetwork(){
            self.showDialog(errorMessage: "You can't play online because you don't have internet connection.")
        }else if closestCircuitId == nil{
            self.showDialog(errorMessage: "You can't play online because there's no circuit nearby.")
        }
    }
    
    
    func checkLocationAuthorizationStatus() {
        if !(CLLocationManager.authorizationStatus() == .authorizedWhenInUse) {
            locationManager.requestWhenInUseAuthorization()
        }
    }
    
    //MARK: Aux functions
    private func showDialog(errorMessage: String){
        let alert = UIAlertController(title: "Warning", message: errorMessage, preferredStyle: .alert)
        alert.addAction(
            UIAlertAction(
                title: NSLocalizedString("OK", comment: "Warning"),
                style: .default,
                handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
     // MARK: - Navigation
    
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let cloudCircuit = segue.destination as? CloudARCircuitViewController {
            cloudCircuit.id = closestCircuitId
        }
     }
    
}
