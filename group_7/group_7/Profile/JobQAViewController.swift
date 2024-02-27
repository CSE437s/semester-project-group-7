//
//  JobQAViewController.swift
//  group_7
//
//  Created by Elysia Quah on 2/23/24.
//

import UIKit
import SwiftUI

class JobQAViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    var nickname: String?
    let jobs = ["Student", "Professional", "Freelancer", "Unemployed", "Other"]

    private lazy var yellowBackgroundView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        view.backgroundColor = .yellow
        return view
    }()
    
    private lazy var textLabel: UILabel = {
        let label = UILabel(frame: CGRect(x:20, y:50, width:UIScreen.main.bounds.width - 40, height:100))
        label.text = nickname! + ", What do you do right now?"
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 30)
        label.numberOfLines = 2
        return label
    }()
    
    private lazy var dropDownMenu: UIPickerView = {
        let dropDownMenu = UIPickerView()
        
        return dropDownMenu
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
        dropDownMenu.translatesAutoresizingMaskIntoConstraints = false
        button.translatesAutoresizingMaskIntoConstraints = false
        
        yellowBackgroundView.addSubview(textLabel)
        yellowBackgroundView.addSubview(dropDownMenu)
        yellowBackgroundView.addSubview(button)
        
        dropDownMenu.delegate = self
        dropDownMenu.dataSource = self
        
        NSLayoutConstraint.activate([
            textLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            textLabel.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: -60),
            textLabel.widthAnchor.constraint(equalToConstant: 280),
            textLabel.heightAnchor.constraint(equalToConstant: 100),
        
            dropDownMenu.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            dropDownMenu.topAnchor.constraint(equalTo: textLabel.bottomAnchor, constant: 20),
            dropDownMenu.widthAnchor.constraint(equalToConstant: 220),
            dropDownMenu.heightAnchor.constraint(equalToConstant: 60),
            
            button.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            button.topAnchor.constraint(equalTo: dropDownMenu.bottomAnchor, constant: 200),
            button.widthAnchor.constraint(equalToConstant: 200),
            button.heightAnchor.constraint(equalToConstant: 40)
        ])
       
    }
    
    @objc func nextButtonTapped() {
        let avatarViewController = AvatarViewController()
        self.navigationController?.pushViewController(avatarViewController, animated: true)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return jobs.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return jobs[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let selectedJob = jobs[row]
    }
}

