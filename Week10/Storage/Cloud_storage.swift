//
//  Cloud_storage.swift
//  Week10
//
//  Created by admin on 06/03/2020.
//  Copyright © 2020 admin. All rights reserved.
//

import Foundation
import FirebaseFirestore
import FirebaseStorage

class Cloud_storage{
    
    private static let storage = Storage.storage()
    private static let db = Firestore.firestore()
    private static let collectionRef = "notes"
    
    func uploadImage(imageView:UIImageView){
         let uuid = UUID().uuidString
         let storageRef = Storage.storage().reference().child("week10/" + uuid + ".jpg")
               if let uploadData = imageView.image!.pngData() {
                storageRef.putData(uploadData, metadata: nil) { (metadata, error) in
                       if error != nil {
                           print("error")
                           
                       } else {
                           // your uploaded photo url.
                        print("Image uploaded")
                       }
                   }
               }
    }
    
    // Week 10
    static func downloadImage(name:String, vc:ViewController){
        let imgRef = storage.reference(withPath: name)
        imgRef.getData(maxSize: 4000000) { (data, error) in
            if error == nil{
                print("Sucess downloading image")
                let img = UIImage(data: data!)
                DispatchQueue.main.async {
                    vc.imageView.image = img
                }
            }else{
                print("Error")
            }
            
        }
    }
}
