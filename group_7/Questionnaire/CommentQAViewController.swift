//
//  CommentQAViewController.swift
//  group_7
//
//  Created by Noah Li on 2024/3/19.
//

import UIKit

class CommentQAViewController:
    UIViewController {
    
    @IBOutlet weak var commentInput: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //单击监听，随便点击一下消除键盘
        let tapSingle=UITapGestureRecognizer(target:self,action:#selector(Tap(_:)))
        //连续点击次数
        tapSingle.numberOfTapsRequired = 1
        //同时按下次数
        tapSingle.numberOfTouchesRequired = 1
        self.view.addGestureRecognizer(tapSingle)
        
        // Set up text field
        commentInput.borderStyle = .roundedRect
        commentInput.translatesAutoresizingMaskIntoConstraints = false // This is important when using Auto Layout

        // Set up Auto Layout constraints
        NSLayoutConstraint.activate([
            // Position the text field at the center of the view
            commentInput.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            commentInput.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 100.0),
            // Set width and height constraints (you can adjust these values)
            commentInput.widthAnchor.constraint(equalToConstant: 300),
            commentInput.heightAnchor.constraint(equalToConstant: 200)
        ])
    
    }
    
    @objc func Tap(_ cognizer:UITapGestureRecognizer)
    {
        commentInput.endEditing(true)
    }
    
    @IBAction func nextButton(_ sender: Any) {
        // Check if there is text and it's not just whitespace
        if let comment = commentInput.text, !comment.trimmingCharacters(in: .whitespaces).isEmpty {
            // Store the comment in UserDefaults
            UserDefaults.standard.set(comment, forKey: "comment")
        } else {
            // Show an alert if the text field is empty or contains only whitespace
            showAlert(withMessage: "Please enter a comment before proceeding.")
        }
    }

    func showAlert(withMessage message: String) {
        let alert = UIAlertController(title: "Notice", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
}

