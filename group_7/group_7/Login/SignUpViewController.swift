//
//  SignUpViewController.swift
//  group_7
//
//  Created by Byeongjun Oh on 2/18/24.
//


import UIKit
import FirebaseAuth
class SignUpViewController: BaseViewController {
    
    let logoimage = UIImageView()
    let usernameTextField = UITextField()
    let fullnameTextField = UITextField()
    let passwordTextField = UITextField()
    let confirmpasswordTextField = UITextField()
    let signupBtn = UIButton(type: .system)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        creatHeaderStr(title: "Sign Up", haveLfet: true, haveRight: false)
        
        logoimage.translatesAutoresizingMaskIntoConstraints = false
        usernameTextField.translatesAutoresizingMaskIntoConstraints = false
        fullnameTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        confirmpasswordTextField.translatesAutoresizingMaskIntoConstraints = false
        signupBtn.translatesAutoresizingMaskIntoConstraints = false
        
        logoimage.image = UIImage(named: "AppIcon")
        
        fullnameTextField.placeholder = "Full Name"
        fullnameTextField.borderStyle = .roundedRect
        fullnameTextField.layer.borderWidth = 1.0
        fullnameTextField.layer.borderColor = UIColor.orange.cgColor
        fullnameTextField.layer.cornerRadius = 5.0
        
        //usernameTextField.frame = CGRect(x:20, y:100, width: 280, height: 40)
        usernameTextField.placeholder = "Email"
        usernameTextField.borderStyle = .roundedRect
        usernameTextField.layer.borderWidth = 1.0
        usernameTextField.layer.borderColor = UIColor.orange.cgColor
        usernameTextField.layer.cornerRadius = 5.0
        
        //passwordTextField.frame = CGRect(x:20, y:150, width: 280, height: 40)
        passwordTextField.placeholder = "Password"
        passwordTextField.borderStyle = .roundedRect
        passwordTextField.layer.borderWidth = 1.0
        passwordTextField.layer.borderColor = UIColor.orange.cgColor
        passwordTextField.layer.cornerRadius = 5.0
        
        confirmpasswordTextField.placeholder = "Confirm Password"
        confirmpasswordTextField.borderStyle = .roundedRect
        confirmpasswordTextField.layer.borderWidth = 1.0
        confirmpasswordTextField.layer.borderColor = UIColor.orange.cgColor
        confirmpasswordTextField.layer.cornerRadius = 5.0
        
        signupBtn.setTitle("Sign Up", for: .normal)
        //loginBtn.frame = CGRect(x: 20, y:200, width: 100, height: 40)
        signupBtn.addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)
        signupBtn.layer.borderWidth = 1.0
        signupBtn.layer.borderColor = UIColor.orange.cgColor
        signupBtn.layer.cornerRadius = 5.0
        
        self.view.addSubview(logoimage)
        self.view.addSubview(fullnameTextField)
        self.view.addSubview(usernameTextField)
        self.view.addSubview(passwordTextField)
        self.view.addSubview(confirmpasswordTextField)
        self.view.addSubview(signupBtn)
        
        NSLayoutConstraint.activate([
            logoimage.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            logoimage.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 40),
            logoimage.widthAnchor.constraint(equalToConstant: 150),
            logoimage.heightAnchor.constraint(equalToConstant: 150),
            
            fullnameTextField.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            fullnameTextField.topAnchor.constraint(equalTo: logoimage.bottomAnchor, constant: 20),
            fullnameTextField.widthAnchor.constraint(equalToConstant: 280),
            fullnameTextField.heightAnchor.constraint(equalToConstant: 40),
            
            usernameTextField.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            usernameTextField.topAnchor.constraint(equalTo: fullnameTextField.bottomAnchor, constant: 20),
            usernameTextField.widthAnchor.constraint(equalToConstant: 280),
            usernameTextField.heightAnchor.constraint(equalToConstant: 40),
        
            passwordTextField.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            passwordTextField.topAnchor.constraint(equalTo: usernameTextField.bottomAnchor, constant: 20),
            passwordTextField.widthAnchor.constraint(equalToConstant: 280),
            passwordTextField.heightAnchor.constraint(equalToConstant: 40),
            
            confirmpasswordTextField.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            confirmpasswordTextField.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 20),
            confirmpasswordTextField.widthAnchor.constraint(equalToConstant: 280),
            confirmpasswordTextField.heightAnchor.constraint(equalToConstant: 40),
            
            signupBtn.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            signupBtn.topAnchor.constraint(equalTo: confirmpasswordTextField.bottomAnchor, constant: 20),
            signupBtn.widthAnchor.constraint(equalToConstant: 280),
            signupBtn.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    //Just in case for going to tab view
    @objc func buttonClicked()
    {
        let email = usernameTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        let confirmpassword = confirmpasswordTextField.text ?? ""
        
        guard password == confirmpassword else {
            print("Passwords do not match.")
            return
        }
        
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let error = error {
                print(error.localizedDescription)
                print("failed")
            } else {
                print("로그인 성공")
                let login = LoginViewController.init()
                login.hidesBottomBarWhenPushed = true
                self.navigationController?.pushViewController(login, animated: true)
            }
        }
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
