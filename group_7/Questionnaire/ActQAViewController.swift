//
//  ActQAViewController.swift
//  group_7
//
//  Created by 李长鸿 on 27/02/2024.
//
 

import UIKit
import SwiftUI

let arr = ["Meditation", "Listen to music", "Journal", "Reading", "Cooking", "Eating", "Exercise", "Take a nap", "Talk to someone", "Watch short videos", "Play mini games"]

var globalCheckboxData = arr.map { str in
    return CheckItem(title: str, state: false)
}

class ActQAViewController: UIViewController {

    @IBOutlet weak var checkboxView: UIView!
    @IBOutlet weak var promptLabel: UILabel!

    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        let sView = CheckboxListView()
        let hostingController = UIHostingController(rootView: sView)
         addChild(hostingController)
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        self.checkboxView.addSubview(hostingController.view)
        self.checkboxView.backgroundColor = .clear
        hostingController.didMove(toParent: self)
         
        NSLayoutConstraint.activate([
                hostingController.view.topAnchor.constraint(equalTo: checkboxView.topAnchor, constant: 20),
                hostingController.view.leftAnchor.constraint(equalTo: checkboxView.leftAnchor, constant: 0),
                hostingController.view.bottomAnchor.constraint(equalTo: checkboxView.bottomAnchor, constant: 100),
                hostingController.view.rightAnchor.constraint(equalTo: checkboxView.rightAnchor, constant: 0)
            ])
        
        promptLabel.layer.zPosition = 1

    }
    
    @IBAction func confirmAction(_ sender: Any) {
        // Filter for selected activities
        let selectedActivities = globalCheckboxData.filter { $0.state }.map { $0.title }

        // Save the selected activities to UserDefaults
        UserDefaults.standard.set(selectedActivities, forKey: "activities")

        // Logging for debug purposes
        selectedActivities.forEach { activity in
            NSLog("User selected: \(activity)")
        }
     }
}
