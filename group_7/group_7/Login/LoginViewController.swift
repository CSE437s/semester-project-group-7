//
//  LoginViewController.swift
//  group_7
//
//  Created by Byeongjun Oh on 2/18/24.
//
import UIKit
import FirebaseAuth
import Firebase
import GoogleSignIn

class LoginViewController: BaseViewController {
    let usernameTextField = UITextField()
    let passwordTextField = UITextField()
    let loginBtn = UIButton(type: .system)
    let googlesignin = UIButton(type: .custom)

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        creatHeaderStr(title: "Login", haveLfet: true, haveRight: false)
        
        usernameTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        loginBtn.translatesAutoresizingMaskIntoConstraints = false
        googlesignin.translatesAutoresizingMaskIntoConstraints = false
        
        //usernameTextField.frame = CGRect(x:20, y:100, width: 280, height: 40)
        usernameTextField.placeholder = "Username"
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
        
        loginBtn.setTitle("Login", for: .normal)
        //loginBtn.frame = CGRect(x: 20, y:200, width: 100, height: 40)
        loginBtn.addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)
        loginBtn.layer.borderWidth = 1.0
        loginBtn.layer.borderColor = UIColor.orange.cgColor
        loginBtn.layer.cornerRadius = 5.0
        
       
        
        let googleIcon = UIImage(named: "googleLogo")
        let scaledIcon = googleIcon?.scaleToSize(size: CGSize(width: 200, height: 40))
        googlesignin.setImage(scaledIcon, for: .normal)
        //googlesignin.tintColor = .clear
        //loginBtn.frame = CGRect(x: 20, y:200, width: 100, height: 40)
        googlesignin.addTarget(self, action: #selector(google), for: .touchUpInside)
        googlesignin.layer.borderWidth = 1.0
        googlesignin.layer.borderColor = UIColor.orange.cgColor
        googlesignin.layer.cornerRadius = 5.0
        
        
        self.view.addSubview(usernameTextField)
        self.view.addSubview(passwordTextField)
        self.view.addSubview(loginBtn)
        self.view.addSubview(googlesignin)
        
        NSLayoutConstraint.activate([
            usernameTextField.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            usernameTextField.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: -60),
            usernameTextField.widthAnchor.constraint(equalToConstant: 280),
            usernameTextField.heightAnchor.constraint(equalToConstant: 40),
        
            passwordTextField.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            passwordTextField.topAnchor.constraint(equalTo: usernameTextField.bottomAnchor, constant: 20),
            passwordTextField.widthAnchor.constraint(equalToConstant: 280),
            passwordTextField.heightAnchor.constraint(equalToConstant: 40),
            
            loginBtn.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            loginBtn.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 20),
            loginBtn.widthAnchor.constraint(equalToConstant: 280),
            loginBtn.heightAnchor.constraint(equalToConstant: 40),
            
            googlesignin.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            googlesignin.topAnchor.constraint(equalTo: loginBtn.bottomAnchor, constant: 20),
            googlesignin.widthAnchor.constraint(equalToConstant: 280),
            googlesignin.heightAnchor.constraint(equalToConstant: 40)
        ])
    }

    
    @objc func buttonClicked()
    {
        let email = usernameTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in guard self != nil else {return}
            
            if let error = error {
                print(error.localizedDescription)
            } else {
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                if let tabBarController = storyboard.instantiateViewController(withIdentifier: "Tab") as? UITabBarController {
                    UIApplication.shared.windows.first?.rootViewController = tabBarController
                    UIApplication.shared.windows.first?.makeKeyAndVisible()
                }
            }
        }
        
    }
    
    @objc func google() {
        GIDSignIn.sharedInstance.restorePreviousSignIn { user, error in
            if error != nil || user == nil {
                print("Not Sign In")
            } else {
                guard let user = user else {return}
                
            }
        }
        
        GIDSignIn.sharedInstance.signIn(withPresenting: self) { signInRes, error in
            guard error == nil else {
                let popup = UIAlertController(title: "Login Failed", message: "Try Again.", preferredStyle: .alert)
                let action = UIAlertAction(title: "OK", style: .default)
                popup.addAction(action)
                self.present(popup, animated: true)
                return
            }
            
            guard let user = signInRes?.user else {return}
            
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            if let tabBarController = storyboard.instantiateViewController(withIdentifier: "Tab") as? UITabBarController {
                UIApplication.shared.windows.first?.rootViewController = tabBarController
                UIApplication.shared.windows.first?.makeKeyAndVisible()
            }
                
        
            
//        guard let clientID = FirebaseApp.app()?.options.clientID else {return}
//        let signInConfig = GIDConfiguration(clientID: clientID)
//
//        GIDSignIn.sharedInstance.signIn(withPresenting: self) { user, error in
//            guard let self = self else { return }
//
//            if let error = error {
//                print(error.localizedDescription)
//                return
//            }
            
            //guard let authentication = user?.authentication,let idToken = authentication.idToken else { return }
//            let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: authentication)
//
//            Auth.auth().signIn(with: credential) { [unowned self] authResult, error in
//                if let error = error {
//                    print(error.localizedDescription)
//                    return
//                }
//                let storyboard = UIStoryboard(name: "Main", bundle: nil)
//                if let tabBarController = storyboard.instantiateViewController(withIdentifier: "Tab") as? UITabBarController {
//                    UIApplication.shared.windows.first?.rootViewController = tabBarController
//                    UIApplication.shared.windows.first?.makeKeyAndVisible()
//                }
//            }
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

extension UIImage {
    func scaleToSize(size: CGSize) -> UIImage {
        let hasAlpha = true
        let scale: CGFloat = 0.0
        UIGraphicsBeginImageContextWithOptions(size, !hasAlpha, scale)
        self.draw(in: CGRect(origin: CGPoint.zero, size: size))
        
        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return scaledImage ?? self
    }
}
