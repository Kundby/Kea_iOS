//
//  FirebaseRepo.swift
//  Week18
//
//  Created by admin on 01/05/2020.
//  Copyright © 2020 admin. All rights reserved.
//

import Foundation
import FirebaseFirestore
import MapKit

class FirebaseRepo  {
    
    private static let db = Firestore.firestore()
    private static let path = "week18pins"
    
    static func startListener(vc: FirstViewController){
        db.collection(path).addSnapshotListener { (snap, error) in
            if error != nil {
                return
            }
            var markers = [MKPointAnnotation]()
            for doc in snap!.documents {
                print("Received data: ")
                let map = doc.data()
                let text = map["title"] as! String
                let latitude = map["lat"] as! Double
                let longitude = map["lon"] as! Double
                let mkAnnotation = MKPointAnnotation()
                mkAnnotation.title = text
                let coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
                mkAnnotation.coordinate = coordinate
                markers.append(mkAnnotation)
                print(text)
                
            }
            vc.updateMarkers(markers: markers)
        }
    }
    
}
