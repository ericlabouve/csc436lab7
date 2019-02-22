//
//  MapViewController.swift
//  
//
//  Created by Eric LaBouve on 2/22/19.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController, MKMapViewDelegate { //}, CLLocationManagerDelegate {

//    let locationManager = CLLocationManager()
    
    @IBOutlet weak var mapView: MKMapView!
    
    let pasoRobles = CLLocationCoordinate2D(latitude: 35.6369, longitude: -120.6545)
    let santaMaria = CLLocationCoordinate2D(latitude: 34.9530, longitude: -120.4357)
    var startCenter: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: (pasoRobles.latitude + santaMaria.latitude) / 2,
                                      longitude: (pasoRobles.longitude + santaMaria.longitude) / 2)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let span = MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2)
        let newRegion = MKCoordinateRegion(center: startCenter, span: span)
        mapView.setRegion(newRegion, animated: true)
//        configureLocationManager()
    }
    
//    func configureLocationManager() {
//        CLLocationManager.locationServicesEnabled()
//        locationManager.requestWhenInUseAuthorization()
//        locationManager.delegate = self
//        locationManager.desiredAccuracy = 1.0
//        locationManager.distanceFilter = 100.0
//        locationManager.startUpdatingLocation()
//    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
