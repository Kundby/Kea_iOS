//
//  Cloud_storage.swift
//  Week_9
//
//  Created by admin on 28/02/2020.
//  Copyright © 2020 admin. All rights reserved.
//

import Foundation
import FirebaseFirestore
class Cloud_storage{
    
    private static var list = [Note]()
    private static let db = Firestore.firestore()
    private static let collectionRef = "notes"

    
    static func startListener(completion: @escaping ([Note]) -> [Note]){
        print("Starting Listener")
        db.collection(collectionRef).addSnapshotListener { (snap, error) in
            
            if error == nil{
                self.list.removeAll()
                for s in snap!.documents{
                    let map = s.data()
                    let head = map["head"] as! String
                    let body = map["body"] as! String
                    let newNote = Note(id: s.documentID, head: head, body: body)
                    list.append(newNote)
                    
                }
                completion(list)
            }
        }
    }
    
    static func createNote(head:String, body:String){
        let docRef = db.collection(collectionRef).document()
        var map = [String:String]()
        map["head"] = head
        map["body"] = body
        docRef.setData(map)
        }
    
    static func deleteNote(id:String){
        let docRef = db.collection(collectionRef).document(id)
        docRef.delete()
    }
    
    static func updateNote(index:Int, head:String, body:String){
        let note = list[index]
        let docRef = db.collection(collectionRef).document(note.id)
        var map = [String:String]()
        map["head"] = head
        map["body"] = body
        docRef.setData(map)
    }
    
    static func getList() -> [Note]{
        return list
    }
    
}
