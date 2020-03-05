//
//  EditController.swift
//  Week_9
//
//  Created by admin on 28/02/2020.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit

class EditController: UIViewController{
    
    var isEditingRow = false
    var headlineText = ""
    var bodyText = ""
    var recievedBody:String?
    var recievedHead:String?
    var rowPosition:Int?
    let home_btn = UINavigationItem(title: "Title")
    
    @IBOutlet weak var home_button: UINavigationItem!
    
    @IBOutlet weak var text_headline: UITextField!
    
    @IBOutlet weak var text_body: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Hides original backButton
        self.navigationItem.hidesBackButton = true
        //Creates new backButton which i can assign func to
        let newBackButton = UIBarButtonItem(title: "Home", style: .plain, target: self, action: #selector(EditController.savePressed(sender:)))
        //Assigns navigation left button item to new button
        self.navigationItem.leftBarButtonItem = newBackButton
        
        if isEditingRow{
            text_headline.text = recievedHead
            text_body.text = recievedBody
            print(rowPosition)
        }
        print(isEditingRow)
    }
    
    @objc func savePressed(sender: UIBarButtonItem) {
        if isEditingRow {
            headlineText = text_headline.text!
            bodyText = text_body.text
            Cloud_storage.updateNote(index: rowPosition!, head: headlineText, body: bodyText)
        }else{
            headlineText = text_headline.text!
            bodyText = text_body.text
            Cloud_storage.createNote(head: headlineText, body: bodyText)
        }
        isEditingRow = false
        _ = navigationController?.popViewController(animated: true)
    }
    
    
    
    
}
