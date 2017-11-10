//
//  MapViewController.swift
//  MiniChallenge5
//
//  Created by Osniel Lopes Teixeira on 06/11/2017.
//  Copyright © 2017 Osniel Lopes Teixeira. All rights reserved.
//

import MapKit
import UIKit
import Alamofire

class MapViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    let locationManager:CLLocationManager = CLLocationManager()
    var lastValidCoordinate: Coordinate!
    let initialLocation = CLLocation(latitude: 21.282778, longitude: -157.829444)
    let regionRadius: CLLocationDistance = 1000
    var circuit = Circuit(coordinates: [Coordinate]())
    
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
    
    @IBAction func didTouchSave(_ sender: Any) {
        
        if lastValidCoordinate != nil{
            circuit.coordinates.append(lastValidCoordinate)
        }
        
        let message:String = "Sua localização atual é "+String(describing: lastValidCoordinate)
        let alert = UIAlertController(title: "Alerta", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
        let jsonEncoder = JSONEncoder()
        let jsonData = try! jsonEncoder.encode(lastValidCoordinate)
        
//        Alamofire.request("https://exemplo1nodejs.herokuapp.com/circuito").response {
//            (response) in
//            print("Get begore inserting:",String(data: response.data!, encoding: String.Encoding.utf8) ?? "empty space")
//        }
//
//        var parameters: [[String:Any]] = []
//
//        for c in circuit.coordinates {
//            let p: [String:Any] = ["coordinate":["lat":c.latitude,"long":c.longitude]]
//            parameters.append(p)
//        }
//
//        let param: Parameters = ["circuit": parameters]
        
        let data = String(data: jsonData, encoding: String.Encoding.utf8)
//
        Alamofire.request("https://exemplo1nodejs.herokuapp.com/circuito", method: .post, parameters: data, encoding: JSONEncoding.default)
//
//        var t: Circuit!
//
//        Alamofire.request("https://exemplo1nodejs.herokuapp.com/circuito").response {
//            (response) in
//            let jsonDecoder = JSONDecoder()
//            do {
//                t = try jsonDecoder.decode(Circuit.self, from: response.data!)
//                print(t)
//            } catch let e {
//                print(e.localizedDescription)
//                print(String(data: response.data!, encoding: String.Encoding.utf8) ?? "empty space")
//            }
//        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        lastValidCoordinate = locations.last?.toCoordinate()
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
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
