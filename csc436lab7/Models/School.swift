//
//  School.swift
//  csc436lab7
//
//  Created by Eric LaBouve on 2/22/19.
//  Copyright © 2019 elabouve. All rights reserved.
//

import Foundation

class School {
    let name: String
    let city: String?
    let state: String?
    let zip: String
    let contact_email: String?
    let latitude: Double
    let longitude: Double
    
    // zip, latitude, and longitude are garunteed after filtering
    init(school: SchoolService.School) {
        name = school.name
        city = school.city
        state = school.state
        zip = school.zip!
        contact_email = school.contact_email
        latitude = school.latitude!
        longitude = school.longitude!
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
