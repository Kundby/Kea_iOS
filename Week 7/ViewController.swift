//
//  ViewController.swift
//  Week7
//
//  Created by admin on 14/02/2020.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    var readText = ""
    var textArray = [String]()
    var editingRow = false
    var positionRow = 0

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var save_button: UIButton!
    @IBOutlet weak var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        // Do any additional setup after loading the view.
        
    }

    @IBAction func savePressed(_ sender: UIButton) {
        if editingRow {
            readText = textView.text
            textArray[positionRow] = readText
        }else{
            readText = textView.text
            textArray.append(readText)
        }
        tableView.reloadData()
        editingRow = false
        textView.text = ""
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return textArray.count
       }
       
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell1")
        cell?.textLabel?.text = textArray[indexPath.row]
        return cell!;
       }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You tapped cell number \(indexPath.row).")
        textView.text = textArray[indexPath.row]
        positionRow = indexPath.row
        editingRow = true
        
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            print("Removed cell number \(indexPath.row) containing \(textArray[indexPath.row])")
            textArray.remove(at: indexPath.row)
            tableView.reloadData()
            
        }
    }
    
}

