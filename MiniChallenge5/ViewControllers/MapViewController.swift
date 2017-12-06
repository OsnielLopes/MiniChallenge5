//
//  MapViewController.swift
//  MiniChallenge5
//
//  Created by Osniel Lopes Teixeira on 06/11/2017.
//  Copyright © 2017 Osniel Lopes Teixeira. All rights reserved.
//

import MapKit
import UIKit
//import Alamofire

class MapViewController: UIViewController, CLLocationManagerDelegate {
    
    //MARK: Outlets
    @IBOutlet weak var mapView: MKMapView!
    
    //MARK: Properties
    let locationManager:CLLocationManager = CLLocationManager()
    var lastValidBow: Bow!
    let initialLocation = CLLocation(latitude: 21.282778, longitude: -157.829444)
    let regionRadius: CLLocationDistance = 1000
    var circuit: Circuit = Circuit.init()
    
    //MARK: Life cicle functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Configuring the map
        centerMapOnLocation(location: initialLocation)
        
        //Configuring the locationManager
        checkLocationAuthorizationStatus()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        //distanceFilter for the locationManager is not defined, keeping the default value
        locationManager.startUpdatingLocation()
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationController?.navigationBar.backgroundColor = UIColor.init(red: 89.0/255.00, green: 46.0/255.0, blue: 185.0/255.0, alpha: 0.57)
        getCircuitFromServer()
    }
    
    // MARK: - Map
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        lastValidBow = locations.last?.toCoordinate()
    }
    
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, regionRadius, regionRadius)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    func checkLocationAuthorizationStatus() {
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            mapView.showsUserLocation = true
            centerMapOnLocation(location: locationManager.location!)
        } else {
            locationManager.requestWhenInUseAuthorization()
        }
    }
    
    func updatePins() {
        for l in circuit.bows{
            mapView.addAnnotation(MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: l.latitude, longitude: l.longitude)))
        }
    }
    
    //MARK - Funcs
    func getCircuitFromServer(){
        let url = URL(string: "https://exemplo1nodejs.herokuapp.com/circuito")!
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            if let data = data{
                let decoder = JSONDecoder()
                DispatchQueue.main.async {
                    do {
                        self.circuit = try decoder.decode(Circuit.self, from: data)
                        self.updatePins()
                    } catch {
                        print("Impossible to decode to circuit from data")
                    }
                }
            }
        }
        task.resume()
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
