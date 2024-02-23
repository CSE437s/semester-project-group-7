//
//  NameQAViewController.swift
//  group_7
//
//  Created by Elysia Quah on 2/22/24.
//

import UIKit

class NameQAViewController:
    UIViewController {

    @IBOutlet weak var nameInput: UITextField!
    
    override func viewDidLoad() {
            super.viewDidLoad()
        }
    
    @IBAction func nextButton(_ sender: Any) {
        if let text = nameInput.text {
                    // store the input in firebase which idk how to do!?
                }
    }

    
}

