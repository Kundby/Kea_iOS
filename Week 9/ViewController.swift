//
//  ViewController.swift
//  Week_9
//
//  Created by admin on 28/02/2020.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    var editingRow = false
    var noteList = [Note]()
    var headline_text = ""
    var body_text = ""
    var positionRow:Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Cloud_storage.startListener(completion: { (list) -> [Note] in
            self.noteList = list
            self.tableView.reloadData()
            return self.noteList
        })
        tableView.dataSource = self
        tableView.delegate = self
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
          //  noteList.remove(at: indexPath.row)
            let id = noteList[indexPath.row].id
            Cloud_storage.deleteNote(id: id)
            tableView.reloadData()
            
        }
    }
    
}

