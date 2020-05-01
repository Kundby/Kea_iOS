//
//  FirstViewController.swift
//  Week18
//
//  Created by admin on 01/05/2020.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit
import MapKit
import FirebaseFirestore

class FirstViewController: UIViewController {

    @IBOutlet weak var map: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
         FirebaseRepo.startListener(vc: self)
    }
    
    func updateMarkers(markers: [MKPointAnnotation]){
        map.removeAnnotations(map.annotations)
        map.addAnnotations(markers)
        
    }

    /*func updateMarkers(markers: [MKPointAnnotation]){
        map.removeAnnotations(map.annotations)
        map.addAnnotations(markers)
        
    }*/
    
    @IBAction func mapTypeToggle(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
            case 0:
                map.mapType = .standard
            case 1:
                map.mapType = .satellite
            default: //Does nothing, but 'default' is needed for the switch statement
                break;
        }
    }
    

}

