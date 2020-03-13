//
//  Story.swift
//  Week11
//
//  Created by admin on 13/03/2020.
//  Copyright © 2020 admin. All rights reserved.
//

import Foundation
class Note {
    var id:String
    var text:String = ""
    var image:String = ""
    
    init(id:String, txt:String, img:String) {
        self.id = id
        self.text = txt
        self.image = img
    }
    
    func hasImage() -> Bool {
        return image.count > 0 // Returns true if there's an image String
    }

}
