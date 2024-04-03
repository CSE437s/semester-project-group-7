//
//  AgeQAViewController.swift
//  group_7
//

import UIKit

class AgeQAViewController:
    UIViewController {
    
    @IBOutlet weak var ageInput: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //单击监听，随便点击一下消除键盘
        let tapSingle=UITapGestureRecognizer(target:self,action:#selector(Tap(_:)))
        //连续点击次数
        tapSingle.numberOfTapsRequired = 1
        //同时按下次数
        tapSingle.numberOfTouchesRequired = 1
        self.view.addGestureRecognizer(tapSingle)
    
    }
    
    @objc func Tap(_ cognizer:UITapGestureRecognizer)
    {
        ageInput.endEditing(true)
    }
    
    @IBAction func nextButton(_ sender: Any) {
        guard let text = ageInput.text, !text.isEmpty else {
                // Handle empty text field case
                showAlert(withMessage: "Please enter your age.")
                return
            }
        
        guard let age = Int(text) else {
            // Handle case where text is not an integer
            showAlert(withMessage: "Please enter a valid age.")
            return
        }
        
        let minAge = 18 // Set the minimum age requirement
        let maxAge = 100 // Set the maximum age limit
        if age < minAge || age > maxAge {
            // Handle case where age is outside the valid range
            showAlert(withMessage: "Age must be between \(minAge) and \(maxAge).")
            return
        }

        if let text = ageInput.text {
            UserDefaults.standard.set(text, forKey: "age")
        }
    }
    
    func showAlert(withMessage message: String) {
        let alert = UIAlertController(title: "Invalid Input", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
}
