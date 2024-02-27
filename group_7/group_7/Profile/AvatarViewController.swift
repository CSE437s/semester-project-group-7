//
//  AvatarViewController.swift
//  group_7
//
//  Created by Byeongjun Oh on 2/27/24.
//

import UIKit

class AvatarViewController : UIViewController {
    private lazy var yellowBackgroundView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        view.backgroundColor = .yellow
        return view
    }()
    
    private lazy var textLabel: UILabel = {
        let label = UILabel(frame: CGRect(x:20, y:50, width:UIScreen.main.bounds.width - 40, height:100))
        label.text = "Click to choose your AVATAR"
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()
    
    private var imageViews: [UIImageView] = []
    
    private lazy var leftArrow: UILabel = {
        let label = UILabel(frame: CGRect(x:20, y:50, width:UIScreen.main.bounds.width, height:100))
        label.text = "<"
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()
         
    private lazy var avatarType: UILabel = {
        let label = UILabel(frame: CGRect(x:20, y:50, width:UIScreen.main.bounds.width + 40, height:100))
        label.text = "Animal"
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()
    
    private lazy var rightArrow: UILabel = {
        let label = UILabel(frame: CGRect(x:20, y:50, width:UIScreen.main.bounds.width - 40, height:100))
        label.text = ">"
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()
    private lazy var button: UIButton = {
        let button = UIButton(type: .system)
            button.frame = CGRect(x: 20, y: 160, width: UIScreen.main.bounds.width - 40, height: 40)
            button.backgroundColor = .white
            button.setTitle("Confirm", for: .normal)
            button.setTitleColor(.black, for: .normal)
            button.layer.cornerRadius = 5
            button.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
            return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(yellowBackgroundView)
        
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        leftArrow.translatesAutoresizingMaskIntoConstraints = false
        avatarType.translatesAutoresizingMaskIntoConstraints = false
        rightArrow.translatesAutoresizingMaskIntoConstraints = false
        button.translatesAutoresizingMaskIntoConstraints = false
        
        let horizontalView = UIStackView()
        horizontalView.axis = .horizontal
        horizontalView.alignment = .center
        horizontalView.distribution = .fillEqually
        horizontalView.spacing = 5
        
        horizontalView.addArrangedSubview(leftArrow)
        horizontalView.addArrangedSubview(avatarType)
        horizontalView.addArrangedSubview(rightArrow)
        horizontalView.translatesAutoresizingMaskIntoConstraints = false
        yellowBackgroundView.addSubview(textLabel)
        NSLayoutConstraint.activate([
            textLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            textLabel.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: -350),
            textLabel.widthAnchor.constraint(equalToConstant: 280),
            textLabel.heightAnchor.constraint(equalToConstant: 100)
        ])
        
        var horizontalImageView = UIStackView()
        var previousImageView = UIStackView()
        for row in 0..<3 {
            horizontalImageView = UIStackView()
            horizontalImageView.axis = .horizontal
            horizontalImageView.alignment = .center
            horizontalImageView.distribution = .fillEqually
            horizontalImageView.spacing = 30
            for col in 0..<3 {
                let image = UIImage(named: String(row*3+col+1))
                let imageView = UIImageView(image: image)
                let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageTapped(_:)))
                imageView.addGestureRecognizer(tapGesture)
                imageView.isUserInteractionEnabled = true
                imageView.autoresizesSubviews = false
                horizontalImageView.addArrangedSubview(imageView)
                imageViews.append(imageView)
            }
            //imageViews.append(horizontalImageView)
            horizontalImageView.translatesAutoresizingMaskIntoConstraints = false
            yellowBackgroundView.addSubview(horizontalImageView)
            NSLayoutConstraint.activate([
                horizontalImageView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
                horizontalImageView.widthAnchor.constraint(equalToConstant: 240),
                horizontalImageView.heightAnchor.constraint(equalToConstant: 120)
            ])
            if row == 0 {
                NSLayoutConstraint.activate([
                    horizontalImageView.topAnchor.constraint(equalTo: textLabel.bottomAnchor, constant: 20)
                ])
            }
            else {
                NSLayoutConstraint.activate([
                    horizontalImageView.topAnchor.constraint(equalTo: previousImageView.bottomAnchor, constant: 20)
                ])
            }
            previousImageView = horizontalImageView
        }

        yellowBackgroundView.addSubview(horizontalView)
        yellowBackgroundView.addSubview(button)
        NSLayoutConstraint.activate([
            horizontalView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            horizontalView.topAnchor.constraint(equalTo: horizontalImageView.bottomAnchor, constant: 20),
            horizontalView.widthAnchor.constraint(equalToConstant: 320),
            horizontalView.heightAnchor.constraint(equalToConstant: 60),

            button.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            button.topAnchor.constraint(equalTo: horizontalView.bottomAnchor, constant: 50),
            button.widthAnchor.constraint(equalToConstant: 200),
            button.heightAnchor.constraint(equalToConstant: 40)
        ])
       
    }
    
    @objc func nextButtonTapped() {
        let loginViewController = LoginViewController()
        self.navigationController?.pushViewController(loginViewController, animated: true)
    }
    
    @objc func imageTapped(_ gesture: UITapGestureRecognizer) {
        guard let imageView = gesture.view as? UIImageView else { return }
        
        for imageView in imageViews {
            imageView.layer.borderWidth = 0
        }
        
        imageView.layer.borderWidth = 2
        imageView.layer.borderColor = UIColor.black.cgColor
    }
}
