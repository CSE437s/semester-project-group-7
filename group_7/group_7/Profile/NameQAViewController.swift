//
//  NameQAViewController.swift
//  group_7
//
//  Created by Elysia Quah on 2/22/24.
//

import UIKit

class NameQAViewController: UIViewController {
    var nickname: String?
    
    private lazy var yellowBackgroundView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        view.backgroundColor = .yellow
        return view
    }()
    
    private lazy var textLabel: UILabel = {
        let label = UILabel(frame: CGRect(x:20, y:50, width:UIScreen.main.bounds.width - 40, height:100))
        label.text = "What should we call you?"
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 30)
        label.numberOfLines = 2
        return label
    }()
    
    private lazy var textField: UITextField = {
        let textField = UITextField(frame: CGRect(x:20, y:100,width: 200, height: 50))
        textField.borderStyle = .roundedRect
        textField.textAlignment = .center
        return textField
    }()
                                    
    private lazy var button: UIButton = {
        let button = UIButton(type: .system)
            button.frame = CGRect(x: 20, y: 160, width: UIScreen.main.bounds.width - 40, height: 40)
            button.backgroundColor = .white
            button.setTitle("Next", for: .normal)
            button.setTitleColor(.black, for: .normal)
            button.layer.cornerRadius = 5
            button.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
            return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(yellowBackgroundView)
        
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textField.translatesAutoresizingMaskIntoConstraints = false
        button.translatesAutoresizingMaskIntoConstraints = false
        
        yellowBackgroundView.addSubview(textLabel)
        yellowBackgroundView.addSubview(textField)
        yellowBackgroundView.addSubview(button)
        
        NSLayoutConstraint.activate([
            textLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            textLabel.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: -60),
            textLabel.widthAnchor.constraint(equalToConstant: 280),
            textLabel.heightAnchor.constraint(equalToConstant: 100),
        
            textField.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            textField.topAnchor.constraint(equalTo: textLabel.bottomAnchor, constant: 20),
            textField.widthAnchor.constraint(equalToConstant: 220),
            textField.heightAnchor.constraint(equalToConstant: 60),
            
            button.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            button.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 200),
            button.widthAnchor.constraint(equalToConstant: 200),
            button.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    @objc func nextButtonTapped() {
        guard let text = textField.text, !text.isEmpty else {
            return
        }
        nickname = text
        
        let ageViewController = AgeQAViewController()
        ageViewController.nickname = nickname
        self.navigationController?.pushViewController(ageViewController, animated: true)
    }
}

