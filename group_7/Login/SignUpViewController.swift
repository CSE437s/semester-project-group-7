import UIKit

class SignUpViewController: UIViewController {
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!

    @IBOutlet weak var signupBox: UIView!
    
    @IBOutlet weak var signupButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        signupBox.applyShadowAndCorners()
        signupButton.applyShadowAndRoundedCorners()
        
        passwordTextField.isSecureTextEntry = true
        emailTextField.autocorrectionType = .no
        
    }

    @IBAction func buttonClicked(_ sender: UIButton) {
        guard let email = emailTextField.text, !email.isEmpty,
              let password = passwordTextField.text, !password.isEmpty else {
            print("Email or password field is empty")
            // Optionally, show an alert to the user
            return
        }

        guard let url = URL(string: "http://127.0.0.1:8000/user/register") else { return }
        

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let parameters: [String: String] = [
            "email": email,  // Ensure this key matches what the server expects
            "pwd": password  // Similarly, ensure this key is expected by the server
        ]

        do {
            let jsonData = try JSONSerialization.data(withJSONObject: parameters, options: [])
            request.httpBody = jsonData
        } catch {
            print("Error serializing JSON: \(error.localizedDescription)")
            // Optionally, show an alert to the user
            return
        }
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in DispatchQueue.main.async {
                guard let httpResponse = response as? HTTPURLResponse,
                      httpResponse.statusCode == 200 else {
                    // Handle HTTP error
                    return
                }

                guard let data = data else {
                    // Handle no data error
                    return
                }
            
                // Parse the JSON response
                do {
                    let jsonResponse = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]

                    if let results = jsonResponse?["results"] as? [String: Any], let userID = results["id"] as? Int {
                        // Store the user ID for later use
                        print("The id is: ", userID)
                        UserDefaults.standard.set(userID, forKey: "userID")
                    }
                    
                    // Handle other parts of the JSON response
                    // Dispatch UI updates to the main queue if needed
                } catch let error {
                    print("JSON parsing error: \(error.localizedDescription)")
                    // Optionally, show an alert to inform the user

                }
            }
        }
        task.resume()
    }
}
