//
//  DetailViewController.swift
//  csc436lab7
//
//  Created by Eric LaBouve on 2/24/19.
//  Copyright © 2019 elabouve. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    var school: School?
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var stateLabel: UILabel!
    @IBOutlet weak var zipLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = school?.name
        cityLabel.text = "City: " + (school?.city ?? "N/A")
        stateLabel.text = "State: " + (school?.state ?? "N/A")
        zipLabel.text = "Zip: " + (school?.zip ?? "N/A")
        emailLabel.text = "Email: " + (school?.contact_email ?? "N/A")
    }
}
