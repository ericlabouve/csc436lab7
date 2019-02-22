//
//  ViewController.swift
//  csc436lab7
//
//  Created by Eric LaBouve on 2/22/19.
//  Copyright © 2019 elabouve. All rights reserved.
//

import UIKit
import Firebase
import MapKit
import GeoFire
import CoreLocation

class ViewController: UIViewController {
    
    var schoolJsonLocs = "https://code.org/schools.json"
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func loadFirebaseWithSchoolDataButton(_ sender: UIButton) {
        // Make the API call to receive the school data
        let session = URLSession(configuration: URLSessionConfiguration.default)
        let request = URLRequest(url: URL(string: schoolJsonLocs)!)
        let task: URLSessionDataTask = session.dataTask(with: request)
        { (receivedData, response, error) -> Void in
            if let data = receivedData {
                do {
                    let decoder = JSONDecoder()
                    let schoolService = try decoder.decode(SchoolService.self, from: data)
                    var schoolList = [School]()
                    // Filter schools to schools whose zip codes start with 93 and store in schoolList
                    for school in schoolService.schools {
                        // Schools must, at least, have a zip, latitude and longitude
                        if let zip = school.zip, let _ = school.latitude, let _ = school.longitude {
                            if zip.starts(with: "93") {
                                schoolList.append(School(school:school))
                            }
                        }
                    }
                    // Save each school to Firebase
                    for school in schoolList {
                        let schoolsRef = FirebaseService.shared.schoolsRef
                        let schoolRef = schoolsRef?.child(school.name)
                        schoolRef?.setValue(school.toDict())
                    }
                    
                } catch {
                    print("Exception on Decode: \(error)")
                }
            }
        }
        task.resume()
    }
}

