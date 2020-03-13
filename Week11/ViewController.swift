//
//  ViewController.swift
//  Week11
//
//  Created by admin on 13/03/2020.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var noteList = [Note]()

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        Cloud_storage.startListener(completion: { (list) -> [Note] in
            self.noteList = list
            self.tableView.reloadData()
            return self.noteList
        })
       // stories.append(Note(txt: "Hi there", img: ""))
     //   stories.append(Note(txt: "Hi You there?", img: ""))
     //   stories.append(Note(txt: "House", img: "squid"))
        tableView.dataSource = self
        tableView.delegate = self
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return noteList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if noteList[indexPath.row].hasImage() {
            //Handles if there's an image
            if let cell = tableView.dequeueReusableCell(withIdentifier: "cell2") as? TableViewCellTextAndImage{
                cell.myLabel.text = noteList[indexPath.row].text
                cell.myImage.image = UIImage(named: noteList[indexPath.row].image)
                //Bruger billede fra assets, da jeg fik en fejl jeg ikke kunne ordne selv, når jeg prøvede at hente billede fra FireStorage og ville indsætte det i den her celle
                return cell
            }
        }else{
            if let cell = tableView.dequeueReusableCell(withIdentifier: "cell1") as? TableViewCellTextOnly {
                cell.myLabel.text = noteList[indexPath.row].text
                return cell
            }
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        //Ternary operator. If statement in 1 line, if there's image, then return 250, else only 80
        return noteList[indexPath.row].hasImage() ? 250 : 80
    }
    
}
