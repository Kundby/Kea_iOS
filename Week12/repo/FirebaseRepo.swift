//
//  FirebaseRepo.swift
//  Week12
//
//  Created by admin on 20/03/2020.
//  Copyright © 2020 admin. All rights reserved.
//

import Foundation
import FirebaseFirestore
import MapKit

class FirebaseRepo  {
    
    private static let db = Firestore.firestore()
    private static let path = "locations"
    
    static func startListener(vc: ViewController){
        db.collection(path).addSnapshotListener { (snap, error) in
            if error != nil {
                return
            }
            var markers = [MKPointAnnotation]()
            for doc in snap!.documents {
                print("Received data: ")
                let map = doc.data()
                let text = map["title"] as! String
                let latitude = map["latitude"] as! Double
                let longitude = map["longitude"] as! Double
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
    
    static func createMarker(title:String, latitude:Double, longitude:Double){
    let docRef = db.collection(path).document()
    var map = [String:Any]()
    map["title"] = title
    map["latitude"] = latitude
    map["longitude"] = longitude
    docRef.setData(map)
    }
    
}
