//
//  Cloud_Storage.swift
//  Week11
//
//  Created by admin on 13/03/2020.
//  Copyright © 2020 admin. All rights reserved.
//

import Foundation
import FirebaseStorage
import FirebaseFirestore


class Cloud_storage{
    private static var list = [Note]()
    private static let db = Firestore.firestore()
    private static let collectionRef = "customTableViewCell"
    private static let storage = Storage.storage()
    
    static func startListener(completion: @escaping ([Note]) -> [Note]){
        print("Starting Listener")
        db.collection(collectionRef).addSnapshotListener { (snap, error) in
            
            if error == nil{
                self.list.removeAll()
                for s in snap!.documents{
                    let map = s.data()
                    let head = map["head"] as! String
                    let image = map["image"] as! String
                    let newNote = Note(id: s.documentID, txt: head, img: image)
                    list.append(newNote)
                    
                }
                completion(list)
            }
        }
    }
    
}
