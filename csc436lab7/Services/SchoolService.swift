//
//  SchoolService.swift
//  csc436lab7
//
//  Created by Eric LaBouve on 2/22/19.
//  Copyright © 2019 elabouve. All rights reserved.
//

import Foundation

// Used to read in JSON object from https://cod.org/shools.json
struct SchoolService: Codable {
    
    let schools: [School]
    
    struct School: Codable {
        let name: String
        let city: String?
        let state: String?
        let zip: String?
        let contact_email: String?
        let latitude: Double?
        let longitude: Double?
    }
}
