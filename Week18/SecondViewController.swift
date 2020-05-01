//
//  SecondViewController.swift
//  Week18
//
//  Created by admin on 01/05/2020.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var symptomList = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        symptomList.append("Cough")
        symptomList.append("Shortness or difficulty of breath")
        symptomList.append("Fever")
        symptomList.append("Chills")
        symptomList.append("Muscle Pain")
        symptomList.append("Headache")
        symptomList.append("Sore Throat")
        symptomList.append("New loss of taste or smell")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
     return symptomList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell1")
        cell?.textLabel?.text = symptomList[indexPath.row]
        return cell!;
       }

}

