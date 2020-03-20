//
//  ViewController.swift
//  Week12
//
//  Created by admin on 20/03/2020.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit
import MapKit
import FirebaseFirestore

class ViewController: UIViewController {

    @IBOutlet weak var map: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        FirebaseRepo.startListener(vc: self)
        let uilongpr = UILongPressGestureRecognizer(target: self, action: #selector(longPressed(gestureRecognized:)))
        uilongpr.minimumPressDuration = 1.5
        
        map.addGestureRecognizer(uilongpr)
        
      /* var marker = MKPointAnnotation()
        marker.title = "HEJSA"
        let location = CLLocationCoordinate2D(latitude: 55.7, longitude: 12.5)
        marker.coordinate = location
        map.addAnnotation(marker)*/
        
    }
    
    func updateMarkers(markers: [MKPointAnnotation]){
        map.removeAnnotations(map.annotations)
        map.addAnnotations(markers)
        
    }

    @objc func longPressed(gestureRecognized: UIGestureRecognizer){
        
               let touchpoint = gestureRecognized.location(in: self.map)
               let coordinate = map.convert(touchpoint, toCoordinateFrom: self.map) //as! GeoPoint
        let latitude = coordinate.latitude
        let longitude = coordinate.longitude
        print(latitude)
        print(longitude)
        
                let alert = UIAlertController(title: "New Pin", message: "Enter title for new pin", preferredStyle: .alert)
                 alert.addTextField { (textField) in
                     textField.text = ""
                 }
                 alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (_) in
                     let alerttextField = (alert?.textFields![0].text)! // Force unwrapping because we know it exists.
                    FirebaseRepo.createMarker(title: alerttextField, latitude: latitude, longitude: longitude)
                     
                 }))
                self.present(alert, animated: true, completion: nil)
        
              /* let annotation = MKPointAnnotation()
               annotation.title = self.alerttextField
               annotation.coordinate = location
               map.addAnnotation(annotation)*/

        //location.latitude location.longitude
           }
    

}

