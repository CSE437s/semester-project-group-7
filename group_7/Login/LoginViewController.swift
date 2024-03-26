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
        
        loginBox.applyShadowAndCorners()
        loginButton.applyShadowAndRoundedCorners()
    }
    
    @IBAction func loginUser(_ sender: UIButton) {
        guard let email = emailTextField.text, !email.isEmpty,
              let password = passwordTextField.text, !password.isEmpty else {
            print("Email or password field is empty")
            // TODO - show an alert to the user
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
            print("Error serializing JSON: \(error.localizedDescription)")
            return
        }
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                guard let httpResponse = response as? HTTPURLResponse,
                      httpResponse.statusCode == 200 else {
                    print("HTTP error")
                    return
                }

                guard let data = data else {
                    print("No data error")
                    return
                }
            
                do {
                    if let jsonResponse = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                       let status = jsonResponse["status"] as? Int, status == 0,
                       let userSer = jsonResponse["results"] as? [String: Any], let userID = userSer["id"] as? Int {
                        UserDefaults.standard.set(userID, forKey: "userID")
                        // Perform segue or update UI to reflect successful login
                    }
                } catch {
                    print("JSON parsing error: \(error.localizedDescription)")
                }
            }
        }
        task.resume()
    }


}
