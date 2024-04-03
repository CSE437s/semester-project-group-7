//
//  ThemesQAViewController.swift
//  group_7
//
//  Created by Noah Li on 2024/3/19.
//

import UIKit
import SwiftUI

let arr2 = ["Stress reduction", "Sleep improvement", "Focus and concentration", "Emotional well-being", "Relationships", "Work-life balance", "Body awareness"]

var globalCheckboxData2 = arr2.map { str in
    return CheckItem(title: str, state: false)
}

class ThemesQAViewController: UIViewController {

    @IBOutlet weak var checkboxView: UIView!
    @IBOutlet weak var promptLabel: UILabel!


    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        let sView = CheckboxListViewII()
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
        // Filter for selected themes
        let selectedThemes = globalCheckboxData.filter { $0.state }.map { $0.title }

        // Save the selected themes to UserDefaults
        UserDefaults.standard.set(selectedThemes, forKey: "themes")

        // Logging for debug purposes
        selectedThemes.forEach { theme in
            NSLog("User selected: \(theme)")
        }
     }
}
