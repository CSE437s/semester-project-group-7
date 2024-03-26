//
//  YesNoQAViewController.swift
//  group_7
//
//  Created by Noah Li on 2024/3/19.
//

import UIKit

class YesNoQAViewController:
    UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func yesButtonTapped(_ sender: UIButton) {
        UserDefaults.standard.set(true, forKey: "hasPracticedMindfulness")
    }
    
    
    @IBAction func noButtonTapped(_ sender: Any) {
        UserDefaults.standard.set(false, forKey: "hasPracticedMindfulness")
    }
    
}
