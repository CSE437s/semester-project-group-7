//
//  BaseViewController.swift
//  MIT
//
//  Created by MIT on 2023/11/13.
//

import UIKit

class BaseViewController: UIViewController,UIGestureRecognizerDelegate {
    lazy var base_topView : UIView = {
        let view = UIView.init(frame: CGRectMake(0,0,SCREEN_WIDTH,topHeight))
        view.backgroundColor = RBG_Text("#D87C43")
        self.view.addSubview(view);
        return view
    }()
    lazy var base_leftBtn : UIButton = {
        let btn = UIButton.init(frame: CGRectMake(0,topHeight-wid(34),wid(32),wid(34)))
        let btnImg = UIImageView(frame: CGRectMake(wid(7),wid(8),wid(18),wid(18)))
        btnImg.image = UIImage(named: "base_return")
        btn.addSubview(btnImg)
        btn.addTarget(self, action: #selector(base_leftBtnAction), for: .touchUpInside)
        self.base_topView.addSubview(btn)
        return btn
    }()
    lazy var bsae_titleLabel : UILabel = {
        let label = creatLabel("Me", BoladFontSize(16),RBG_Text("#FFFFFF"))
        label.textAlignment = .center
        label.frame = CGRectMake(wid(32),topHeight-wid(34),SCREEN_WIDTH-wid(32)*2,wid(34))
        self.base_topView.addSubview(label)
        label.text = ""
        return label
    }()
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = RBG_Text("#F5F4F4");
        // Do any additional setup after loading the view.
    }
    func creatHeaderStr(title : String,haveLfet : Bool,haveRight : Bool)
    {
        self.bsae_titleLabel.text = title
        if(haveLfet)
        {
            self.base_leftBtn.alpha = 1
        }
    }
    @objc func base_leftBtnAction()
    {
        self.navigationController?.popViewController(animated: true)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
