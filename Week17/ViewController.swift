//
//  ViewController.swift
//  Week17
//
//  Created by admin on 24/04/2020.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit
import CoreMotion

class ViewController: UIViewController {
    
    var pedometer = CMPedometer()
    
    @IBOutlet weak var stepsLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var paceLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
     }

    @IBAction func startPressed(_ sender: Any) {
        pedometer.startUpdates(from: Date()) { (data, error) in
            DispatchQueue.main.async {
                if(error == nil){
                    self.stepsLabel.text = data?.numberOfSteps.stringValue
                    self.distanceLabel.text = data?.distance?.stringValue
                    self.paceLabel.text = data?.averageActivePace?.stringValue
                }
            }
        }
    }
    
    @IBAction func stopPressed(_ sender: Any) {
        pedometer.stopUpdates()
    }
    
}

