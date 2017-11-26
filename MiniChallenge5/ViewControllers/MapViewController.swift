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
    
    @IBOutlet weak var mapView: MKMapView!
    let locationManager:CLLocationManager = CLLocationManager()
    var lastValidPoint: Point!
    let initialLocation = CLLocation(latitude: 21.282778, longitude: -157.829444)
    let regionRadius: CLLocationDistance = 1000
    var circuit: Circuit = Circuit.init(id: nil)
    
    
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
        getCircuitFromServer()
    }
    
    @IBAction func didTouchSave(_ sender: Any) {
        
        if lastValidPoint != nil{
            let jsonEncoder = JSONEncoder()
            do {
                let jsonData = try jsonEncoder.encode(circuit)
                
                let url = URL(string: "https://exemplo1nodejs.herokuapp.com/circuito")!
                var request = URLRequest(url: url)
                request.httpMethod = "POST"
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                
                let task = URLSession.shared.uploadTask(with: request, from: jsonData) { data, response, error in
                    if let error = error {
                        // handle the transport error
                        print(error.localizedDescription)
                        return
                    }
                }
                task.resume()
                circuit.points.append(lastValidPoint)
                updatePins()
            } catch {
                print("Impossible to generate JSON from circuit")
            }
        }
        
    }
    
    // MARK: - Map
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        lastValidPoint = locations.last?.toCoordinate()
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
        for l in circuit.points{
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
