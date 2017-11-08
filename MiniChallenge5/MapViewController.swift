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
        let message:String = "Sua localização atual é "+String(describing: lastValidCoordinate)
        let alert = UIAlertController(title: "Alerta", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
        Alamofire.request(.GET, "https://exemplo1nodejs.herokuapp.com/circuito")
            .response { request, response, data, error in
                print(request)
                print(response)
                print(error)
        }
        
//        let url = URL(string:"https://exemplo1nodejs.herokuapp.com/circuito")
//        let task = URLSession.shared.dataTask(with:url!) {
//            (data,response,error) in
//            print(error.debugDescription)
//            if let data = data,
//            let html = String(data: data, encoding: String.Encoding.utf8) {
//
//                print("Response: \(html)")
//
//                // JSON Decoder
//                let jsonData = html.data(using:.utf8)!
//                print("-> JSON DATA \(jsonData)")
//                let decoder = JSONDecoder()
//                let u = try! decoder.decode(String.self,from:jsonData)
//                print("-> JSON DECODED \(u)")
//                // Essa variável 'u' é o seu json de resposta decodificado
//            }
//        }
//        task.resume()
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
