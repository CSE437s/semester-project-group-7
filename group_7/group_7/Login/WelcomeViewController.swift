//
//  WelcomeViewController.swift
//  group_7
//
//  Created by Byeongjun Oh on 2/18/24.
//

import UIKit

class WelcomeViewController: UIViewController {

    private var titleLabel : UILabel!
    
    private lazy var topView : UIView = {
        let backViwe = UIView.init(frame: CGRectMake(0,StatusBarHeight+wid(20),SCREEN_WIDTH,self.sliderImgView.y-(StatusBarHeight+wid(20))))
        let lineView = UIView.init(frame: CGRectMake(0,0,SCREEN_WIDTH,1))
        lineView.backgroundColor = RBG(60,72,96)
        backViwe.addSubview(lineView)
        let lineView1 = UIView.init(frame: CGRectMake(0,lineView.bottom+wid(28),SCREEN_WIDTH,1))
        lineView1.backgroundColor = RBG(60,72,96)
        backViwe.addSubview(lineView1)
        self.titleLabel = creatLabel("",BoladFontSize(25),.black)
        self.titleLabel.frame = CGRectMake(0,lineView1.bottom,SCREEN_WIDTH,backViwe.height-lineView1.bottom)
        self.titleLabel.numberOfLines = 0
        self.titleLabel.textAlignment = .center
        self.titleLabel.adjustsFontSizeToFitWidth = true
        self.titleLabel.baselineAdjustment = .alignBaselines
        backViwe.addSubview(self.titleLabel)
        self.view.addSubview(backViwe)
        return backViwe
    }()
    private lazy var sliderImgView : WelcomeSliderImgView = {
        let view = WelcomeSliderImgView.init(frame: CGRectMake(0,self.signBtn.y-(ISIphoneX ? wid(380) : wid(320)),SCREEN_WIDTH,(ISIphoneX ? wid(305) : wid(280))))
        self.view.addSubview(view)
        return view
    }()
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
        self.view.backgroundColor = .white
        self.topView.alpha = 1
        self.loginBtn.alpha = 1
        self.sliderImgView.alpha = 1
        self.sliderImgView.refreshData(["1","2","3"])
        self.titleLabel.text = "“Welcome to Another Me”"
        // Do any additional setup after loading the view.
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

