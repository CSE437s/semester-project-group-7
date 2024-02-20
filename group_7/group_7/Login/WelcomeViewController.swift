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
        let imageView = UIImageView(frame: CGRect(x:0,y:100,width:backView.frame.width, height:backView.frame.height*0.3))
        imageView.image = UIImage(named: "1")
        imageView.contentMode = .scaleAspectFit
        backView.addSubview(imageView)
        
        let mainTextLabel = UILabel(frame: CGRect(x:0,y:imageView.frame.maxY, width: backView.frame.width, height: 30))
        mainTextLabel.text = "Welcome to"
        mainTextLabel.textColor = .black
        mainTextLabel.textAlignment = .center
        mainTextLabel.font = UIFont.boldSystemFont(ofSize: 25)
        mainTextLabel.numberOfLines = 0
        backView.addSubview(mainTextLabel)
        
        let boldTextLabel = UILabel(frame: CGRect(x: 0, y: mainTextLabel.frame.maxY, width: backView.frame.width, height: 30))
        boldTextLabel.text = "AnotherMe"
        boldTextLabel.textColor = .black
        boldTextLabel.textAlignment = .center
        boldTextLabel.font = UIFont.boldSystemFont(ofSize: 25)
        backView.addSubview(boldTextLabel)
        
        let normalTextLabel = UILabel(frame: CGRect(x: 0, y: boldTextLabel.frame.maxY, width: backView.frame.width, height: 30))
        normalTextLabel.text = "\"A better version of oneself\""
        normalTextLabel.textColor = .black
        normalTextLabel.textAlignment = .center
        normalTextLabel.font = UIFont.systemFont(ofSize: 25)
        backView.addSubview(normalTextLabel)
        
        let button = UIButton(frame: CGRect(x: wid(25), y: normalTextLabel.frame.maxY + wid(12), width: SCREEN_WIDTH - wid(55), height: wid(45)))
        button.layer.cornerRadius = button.frame.height / 2.0
        button.layer.masksToBounds = true
        button.backgroundColor = RBG(255, 255, 255)
        button.setTitle("Let's Go!", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        button.addTarget(self, action: #selector(loginBtnAction), for: .touchUpInside)
        backView.addSubview(button)
        
        let smallTextLabel = UILabel(frame: CGRect(x:wid(55), y:button.frame.maxY + wid(12), width:SCREEN_WIDTH-wid(55)*2, height: wid(20)))
        smallTextLabel.text = "By continuing you accept our Privacy Policy, Term of Use, and Subscription Terms"
        smallTextLabel.textColor = .black
        smallTextLabel.textAlignment = .center
        smallTextLabel.font = UIFont.systemFont(ofSize: 10)
        backView.addSubview(smallTextLabel)
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

