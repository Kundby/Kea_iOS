//
//  marker.swift
//  Week12
//
//  Created by admin on 20/03/2020.
//  Copyright © 2020 admin. All rights reserved.
//

import Foundation
import FirebaseFirestore

class marker{
    
       var title:String
       var location:GeoPoint
       
       init(title:String, location:GeoPoint) {
           self.title = title
           self.location = location
       }
    
}
