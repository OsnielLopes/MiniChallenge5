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
    let locationManager: CLLocationManager = CLLocationManager()
    let regionRadius: CLLocationDistance = 1000
    let locations: [Bow] = [Bow]()
    let circuitDataManager: CircuitDataManager = CircuitDataManager()
    
    
    //MARK: Life cicle functions
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        checkLocationAuthorizationStatus()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        centerMapOnLocation(location: locationManager.location!)
        
        self.circuitDataManager.getCircuitLocations(callback: {locations in
            for (_, location) in locations {
                self.mapView.addAnnotation(
                    MKPlacemark(
                        coordinate: CLLocationCoordinate2D(
                            latitude: location.latitude,
                            longitude: location.longitude)
                    )
                )
            }
        })
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationController?.navigationBar.backgroundColor =
            UIColor(red: 89.0/255.00, green: 46.0/255.0, blue: 185.0/255.0, alpha: 0.57)
    }
    
    //MARK: Aux functions
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
//        for l in circuit.bows{
//            mapView.addAnnotation(MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: l.latitude, longitude: l.longitude)))
//        }
    }
}
