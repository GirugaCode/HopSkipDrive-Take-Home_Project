//
//  RideDetailsViewController.swift
//  HopSkipDrive-Take-Home-Project
//
//  Created by Ryan Nguyen on 8/14/21.
//

import SnapKit
import UIKit

class RideDetailsViewController: UIViewController {
    //MARK: - PROPERTIES
    var ride: Ride?
    
    //MARK: - VIEW CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .darkGray
        navigationItem.title = "Ride Details"
    }
}
