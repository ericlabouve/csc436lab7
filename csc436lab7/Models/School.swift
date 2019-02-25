//
//  School.swift
//  csc436lab7
//
//  Created by Eric LaBouve on 2/22/19.
//  Copyright © 2019 elabouve. All rights reserved.
//

import Foundation
import MapKit
import FirebaseDatabase

class School: NSObject, MKAnnotation, Codable {
    var name: String
    var city: String?
    var state: String?
    var zip: String
    var contact_email: String?
    var latitude: Double
    var longitude: Double
    var coordinate: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    var location: CLLocation {
        return CLLocation(latitude: latitude, longitude: longitude)
    }
    var title: String? {
        return name
    }
    var subtitle: String? {
        return city
    }
    
    // zip, latitude, and longitude are garunteed after filtering
    init(school: SchoolService.School) {
        name = school.name.replacingOccurrences(of: ".", with: "")
        city = school.city
        state = school.state
        zip = school.zip!
        contact_email = school.contact_email
        latitude = school.latitude!
        longitude = school.longitude!
        super.init()
    }
    
    // Initiate a School object given the data received from a Geofire query
    init(key: String, snapshot: DataSnapshot) {
        name = key
        
        let snaptemp = snapshot.value as! [String : AnyObject]
        let snapvalues = snaptemp[key] as! [String : AnyObject]
        
        name = snapvalues["name"] as? String ?? "N/A"
        city = snapvalues["city"] as? String ?? "N/A"
        state = snapvalues["state"] as? String ?? "N/A"
        zip = snapvalues["zip"] as? String ?? "N/A"
        contact_email = snapvalues["contact_email"] as? String ?? "N/A"
        latitude = snapvalues["latitude"] as? Double ?? 0.0
        longitude = snapvalues["longitude"] as? Double ?? 0.0
        
        super.init()
    }
    
    func toDict() -> [String : Any] {
        return [
            "name" : name,
            "city" : city ?? "",
            "state" : state ?? "",
            "zip" : zip,
            "contact_email" : contact_email ?? "",
            "latitude" : latitude,
            "longitude" : longitude
        ]
    }
}
