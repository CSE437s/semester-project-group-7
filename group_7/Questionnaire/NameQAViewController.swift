//
//  NameQAViewController.swift
//  group_7
//

import UIKit

class NameQAViewController:
    UIViewController {

    @IBOutlet weak var nameInput: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //单击监听，随便点击一下消除键盘
        let tapSingle=UITapGestureRecognizer(target:self,action:#selector(Tap(_:)))
        //连续点击次数
        tapSingle.numberOfTapsRequired = 1
        //同时按下次数
        tapSingle.numberOfTouchesRequired = 1
        self.view.addGestureRecognizer(tapSingle)
        
        nameInput.autocorrectionType = .no
    }
    
    @objc func Tap(_ cognizer:UITapGestureRecognizer) {
        nameInput.endEditing(true)
    }
    
    @IBAction func nextButton(_ sender: Any) {
        guard let text = nameInput.text, !text.isEmpty else {
            // Handle empty text field case
            showAlert(withMessage: "Please enter a name.")
            return
        }

        let minLength = 2 // Set the minimum length requirement for the name
        if text.count < minLength {
            // Handle case where text length is below minimum required length
            showAlert(withMessage: "Name must be at least \(minLength) characters long.")
            return
        }
        
        if let text = nameInput.text {
            UserDefaults.standard.set(text, forKey: "name")
        }
    }
    
    
    func showAlert(withMessage message: String) {
        let alert = UIAlertController(title: "Invalid Input", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}
