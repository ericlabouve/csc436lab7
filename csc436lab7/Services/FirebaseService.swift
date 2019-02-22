//
//  FirebaseService.swift
//  csc436lab7
//
//  Created by Eric LaBouve on 2/22/19.
//  Copyright © 2019 elabouve. All rights reserved.
//

import Foundation
import Firebase
import FirebaseDatabase
import GeoFire

class FirebaseService {
    static let shared = FirebaseService()
    
    var schoolsRef : DatabaseReference?
    var geoFire : GeoFire?
    
    private init() {
        schoolsRef = Database.database().reference().child("Schools")
        geoFire = GeoFire(firebaseRef: Database.database().reference().child("GeoFire"))
    }
}
