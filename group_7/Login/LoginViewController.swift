//
//  LoginViewController.swift
//  group_7
//
import UIKit

class LoginViewController: UIViewController {
    
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var loginBox: UIView!
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        passwordTextField.isSecureTextEntry = true
        emailTextField.autocorrectionType = .no
        
        loginBox.applyShadowAndCorners()
        loginButton.applyShadowAndRoundedCorners()
        
    }
    

    
    @IBAction func loginUser(_ sender: UIButton) {
        guard let email = emailTextField.text, !email.isEmpty,
              let password = passwordTextField.text, !password.isEmpty else {
            showAlert(withMessage: "Email or password field cannot be empty.")
            return
        }

        guard let url = URL(string: "http://127.0.0.1:8000/user/login") else { return }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let parameters: [String: String] = [
            "email": email,
            "pwd": password
        ]

        do {
            let jsonData = try JSONSerialization.data(withJSONObject: parameters, options: [])
            request.httpBody = jsonData
        } catch {
            showAlert(withMessage: "Error serializing JSON: \(error.localizedDescription)")
            return
        }

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                if let error = error {
                    self.showAlert(withMessage: "Request error: \(error.localizedDescription)")
                    return
                }

                guard let httpResponse = response as? HTTPURLResponse,
                      httpResponse.statusCode == 200 else {
                    self.showAlert(withMessage: "HTTP error or server not responding with 200 OK.")
                    return
                }

                guard let data = data else {
                    self.showAlert(withMessage: "No data received from server.")
                    return
                }

                do {
                    if let jsonResponse = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                        // Ensure that all logic that uses jsonResponse is within this block
                        if let status = jsonResponse["status"] as? Int, status == 0,
                           let userSer = jsonResponse["results"] as? [String: Any], let userID = userSer["id"] as? Int {
                            UserDefaults.standard.set(userID, forKey: "userID")
                            // Perform segue programmatically since login is successful
                            self.performSegue(withIdentifier: "loginToNextVC", sender: self)
                        } else {
                            // Handle login failure based on server response
                            let message = jsonResponse["msg"] as? String ?? "Login failed due to unknown error."
                            self.showAlert(withMessage: message)
                        }
                    }
                } catch {
                    self.showAlert(withMessage: "JSON parsing error: \(error.localizedDescription)")
                }
            }
        }
        task.resume()


    }

    func showAlert(withMessage message: String) {
        let alert = UIAlertController(title: "Login Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }


}
