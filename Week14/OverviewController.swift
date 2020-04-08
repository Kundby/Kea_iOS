//
//  OverviewController.swift
//  Week14_CloudLogin
//
//  Created by admin on 08/04/2020.
//  Copyright © 2020 admin. All rights reserved.
//
import UIKit

class OverviewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    var editingRow = false
    var noteList = [Note]()
    var headline_text = ""
    var body_text = ""
    var positionRow:Int?
    var firebaseManager:FirebaseManager?
    let logout_btn = UINavigationItem(title: "Title")
    
    @IBOutlet weak var logout_button: UINavigationItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
            firebaseManager = FirebaseManager(parentVC: self)
            Cloud_storage.startListener(completion: { (list) -> [Note] in
            self.noteList = list
            self.tableView.reloadData()
            return self.noteList
        })
        tableView.dataSource = self
        tableView.delegate = self
        
        //Hides original backButton
        self.navigationItem.hidesBackButton = true
        //Creates new backButton which i can assign func to
        let newBackButton = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(OverviewController.logoutPressed(sender:)))
        //Assigns navigation left button item to new button
        self.navigationItem.leftBarButtonItem = newBackButton
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return noteList.count
       }
       
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell1")
        cell?.textLabel?.text = noteList[indexPath.row].head
        return cell!;
       }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        print("You tapped cell number \(indexPath.row).")
        editingRow = true
        positionRow = indexPath.row
        headline_text = noteList[indexPath.row].head
        body_text = noteList[indexPath.row].body
        performSegue(withIdentifier: "cellSegue", sender: cell)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let recieverVC = segue.destination as! EditController
        if editingRow{
            editingRow = false
            recieverVC.recievedHead = headline_text
            recieverVC.recievedBody = body_text
            recieverVC.isEditingRow = true
            recieverVC.rowPosition = positionRow
        }
        
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            print("Removed cell number \(indexPath.row) containing \(noteList[indexPath.row])")
            let id = noteList[indexPath.row].id
            Cloud_storage.deleteNote(id: id)
            tableView.reloadData()
            
        }
    }
    
    @objc func logoutPressed(sender: UIBarButtonItem) {
        print("Logout button pressed")
        firebaseManager?.signOut()
        //Triggers animation
        _ = navigationController?.popViewController(animated: true)
    }
    
}
