//
//  MapViewController.swift
//  
//
//  Created by Eric LaBouve on 2/22/19.
//

import UIKit
import MapKit
import CoreLocation
import GeoFire

class MapViewController: UIViewController, MKMapViewDelegate {

    @IBOutlet weak var mapView: MKMapView!
    var regionQuery : GFRegionQuery?
    
    let pasoRobles = CLLocationCoordinate2D(latitude: 35.649319, longitude: -120.672830)
    let santaMaria = CLLocationCoordinate2D(latitude: 34.935633, longitude: -120.448771)
    var startCenter: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: (pasoRobles.latitude + santaMaria.latitude) / 2,
                                      longitude: (pasoRobles.longitude + santaMaria.longitude) / 2)
    }
    // Keep track of the last annotation selected
    var selectedAnnotation: School?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let span = MKCoordinateSpan(latitudeDelta: 0.42, longitudeDelta: 0.42)
        let newRegion = MKCoordinateRegion(center: startCenter, span: span)
        mapView.setRegion(newRegion, animated: true)
        
    }
    
    // Hide the navigation bar when showing the map
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }

    
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        mapView.removeAnnotations(mapView.annotations)

        if let oldQuery = regionQuery {
            oldQuery.removeAllObservers()
        }
        
        let geoFireRef = FirebaseService.shared.geoFire
        regionQuery = geoFireRef?.query(with: mapView.region)

        regionQuery?.observe(.keyEntered, with: { (key, location) in
            let databaseRef = FirebaseService.shared.schoolsRef
            databaseRef?.queryOrderedByKey().queryEqual(toValue: key).observe(.value, with: { snapshot in

                let school = School(key:key, snapshot:snapshot)
                self.addSchoolAnnotation(school)
            })
        })
    }

    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
        mapView.setRegion(MKCoordinateRegion.init(center: (mapView.userLocation.location?.coordinate)!, span: MKCoordinateSpan(latitudeDelta: 0.15, longitudeDelta: 0.15)), animated: true)
    }

    func addSchoolAnnotation(_ school : School) {
        DispatchQueue.main.async {
            self.mapView.addAnnotation(school)
        }
    }

    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {

        if annotation is School {
            let annotationView = MKPinAnnotationView()
            annotationView.pinTintColor = .red
            annotationView.annotation = annotation
            annotationView.canShowCallout = true
            annotationView.animatesDrop = true
            // add callout disclosure button
            annotationView.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)

            return annotationView
        }

        return nil
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        performSegue(withIdentifier: "MapToDetail", sender: self)
    }
    
    
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        selectedAnnotation = view.annotation as? School
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "MapToDetail" {
            let destVC = segue.destination as! DetailViewController
            destVC.school = selectedAnnotation
        }
    }
    

}
