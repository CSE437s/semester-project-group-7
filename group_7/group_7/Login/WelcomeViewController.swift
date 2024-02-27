//
//  WelcomeViewController.swift
//  group_7
//
//  Created by Byeongjun Oh on 2/18/24.
//

import UIKit

class WelcomeViewController: UIViewController {

    private var titleLabel : UILabel!
  
    private lazy var signBtn : UIButton = {
        let btn = UIButton.init(frame: CGRectMake(wid(55),SCREEN_HEIGHT-wid(160),SCREEN_WIDTH-wid(55)*2,wid(45)))
        btn.layer.cornerRadius = btn.height/2.0
        btn.layer.masksToBounds = true
        btn.backgroundColor = RBG(61,84,181)
        btn.setTitle("Sign up", for: .normal)
        btn.setTitleColor(.white, for:.normal)
        btn.titleLabel?.font = fontSizeR(15)
        btn.addTarget(self, action: #selector(signBtnAction), for: .touchUpInside)
        self.view.addSubview(btn)
        return btn
    }()
    private lazy var loginBtn : UIButton = {
        let btn = UIButton.init(frame: CGRectMake(wid(55),self.signBtn.bottom+wid(12),SCREEN_WIDTH-wid(55)*2,wid(45)))
        btn.layer.cornerRadius = btn.height/2.0
        btn.layer.masksToBounds = true
        btn.layer.borderColor = RBG(61,84,181).cgColor
        btn.layer.borderWidth = 1
        btn.setTitle("Log in", for: .normal)
        btn.setTitleColor(RBG(61,84,181), for:.normal)
        btn.titleLabel?.font = fontSizeR(15)
        btn.addTarget(self, action: #selector(loginBtnAction), for: .touchUpInside)
        self.view.addSubview(btn)
        return btn
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.view.backgroundColor = .white
//        self.topView.alpha = 1
//        self.loginBtn.alpha = 1
//        self.sliderImgView.alpha = 1
//        self.sliderImgView.refreshData(["1","2","3"])
//        self.titleLabel.text = "Welcome to Another Me"
        // Do any additional setup after loading the view.
        let backView = UIView(frame: CGRectMake(0,StatusBarHeight+wid(20),SCREEN_WIDTH,self.view.frame.height-(StatusBarHeight+wid(20))))
        backView.backgroundColor = .yellow
        self.view.addSubview(backView)
        let imageView = UIImageView(frame: CGRect(x:0,y:100,width:backView.frame.width, height:backView.frame.height*0.7))
        imageView.image = UIImage(named: "Welcome")
        imageView.contentMode = .scaleAspectFit
       
        let mainTextLabel = UILabel(frame: CGRect(x:0,y:imageView.frame.maxY, width: backView.frame.width, height: 30))
        mainTextLabel.text = "Welcome to"
        mainTextLabel.textColor = .black
        mainTextLabel.textAlignment = .center
        mainTextLabel.font = UIFont.systemFont(ofSize: 30)
        mainTextLabel.numberOfLines = 0
        
        let boldTextLabel = UILabel(frame: CGRect(x: 0, y: mainTextLabel.frame.maxY, width: backView.frame.width, height: 30))
        boldTextLabel.text = "AnotherMe"
        boldTextLabel.textColor = .black
        boldTextLabel.textAlignment = .center
        boldTextLabel.font = UIFont.boldSystemFont(ofSize: 50)
       
        let normalTextLabel = UILabel(frame: CGRect(x: 0, y: boldTextLabel.frame.maxY, width: backView.frame.width, height: 30))
        normalTextLabel.text = "\"A better version of oneself\""
        normalTextLabel.textColor = .black
        normalTextLabel.textAlignment = .center
        normalTextLabel.font = UIFont.italicSystemFont(ofSize: 20)
        normalTextLabel.numberOfLines = 2
        
        let button = UIButton(frame: CGRect(x: wid(25), y: normalTextLabel.frame.maxY + wid(12), width: SCREEN_WIDTH - wid(55), height: wid(45)))
        button.layer.cornerRadius = button.frame.height / 2.0
        button.layer.masksToBounds = true
        button.backgroundColor = RBG(255, 255, 255)
        button.setTitle("Let's Go!", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        button.addTarget(self, action: #selector(loginBtnAction), for: .touchUpInside)
        
        let smallTextLabel = UILabel(frame: CGRect(x:wid(55), y:button.frame.maxY + wid(12), width:SCREEN_WIDTH-wid(55)*2, height: wid(20)))
        smallTextLabel.text = "By continuing you accept our Privacy Policy, Term of Use, and Subscription Terms"
        smallTextLabel.textColor = .black
        smallTextLabel.textAlignment = .center
        smallTextLabel.font = UIFont.systemFont(ofSize: 10)
        smallTextLabel.numberOfLines = 2
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        mainTextLabel.translatesAutoresizingMaskIntoConstraints = false
        boldTextLabel.translatesAutoresizingMaskIntoConstraints = false
        normalTextLabel.translatesAutoresizingMaskIntoConstraints = false
        button.translatesAutoresizingMaskIntoConstraints = false
        smallTextLabel.translatesAutoresizingMaskIntoConstraints = false
        
        backView.addSubview(imageView)
        backView.addSubview(mainTextLabel)
        backView.addSubview(boldTextLabel)
        backView.addSubview(normalTextLabel)
        backView.addSubview(button)
        backView.addSubview(smallTextLabel)
        
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: -60),
            imageView.widthAnchor.constraint(equalToConstant: 280),
            imageView.heightAnchor.constraint(equalToConstant: 280),
        
            mainTextLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            mainTextLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20),
            mainTextLabel.widthAnchor.constraint(equalToConstant: 280),
            mainTextLabel.heightAnchor.constraint(equalToConstant: 40),
            
            boldTextLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            boldTextLabel.topAnchor.constraint(equalTo: mainTextLabel.bottomAnchor, constant: 20),
            boldTextLabel.widthAnchor.constraint(equalToConstant: 280),
            boldTextLabel.heightAnchor.constraint(equalToConstant: 40),
            
            normalTextLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            normalTextLabel.topAnchor.constraint(equalTo: boldTextLabel.bottomAnchor, constant: 20),
            normalTextLabel.widthAnchor.constraint(equalToConstant: 280),
            normalTextLabel.heightAnchor.constraint(equalToConstant: 40),
            
            button.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            button.topAnchor.constraint(equalTo: normalTextLabel.bottomAnchor, constant: 50),
            button.widthAnchor.constraint(equalToConstant: 280),
            button.heightAnchor.constraint(equalToConstant: 40),
            
            smallTextLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            smallTextLabel.topAnchor.constraint(equalTo: button.bottomAnchor, constant: 5),
            smallTextLabel.widthAnchor.constraint(equalToConstant: 280),
            smallTextLabel.heightAnchor.constraint(equalToConstant: 80)
        ])
    }

    @objc func signBtnAction()
    {
        print("signIn")
        let sign = SignUpViewController.init()
        sign.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(sign, animated: true)
    }

    @objc func loginBtnAction()
    {
        print("Login")
        if let navi = self.navigationController {
            let login = LoginViewController()
            login.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(login, animated: true)
        }
        else {
            print("controller")
        }
    }

}

