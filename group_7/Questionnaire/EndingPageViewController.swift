//
//  EngingPageViewController.swift
//  group_7
//
//  Created by Noah Li on 2024/3/19.
//

import UIKit

class EndingPageViewController:
    UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func tothemain(_ sender: Any) {
        guard let url = URL(string: "http://127.0.0.1:8000/user/hobby") else { return }
        
        guard let userID = UserDefaults.standard.value(forKey: "userID") as? Int else {
            print("User ID not found")
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let profileData: [String: Any] = [
            "id": userID,
            "name": UserDefaults.standard.string(forKey: "name") ?? "default name",
            "age": UserDefaults.standard.string(forKey: "age") ?? 0,
            "work": UserDefaults.standard.string(forKey: "occupation") ?? "default occupation",
            "avatar": UserDefaults.standard.string(forKey: "SelectedAvatarURL") ?? "default avatar",
            "feel": UserDefaults.standard.string(forKey: "emoji") ?? "default emoji",
            "activities": UserDefaults.standard.string(forKey: "activities") ?? "default activities",
            "mindfulness": UserDefaults.standard.string(forKey: "hasPracticedMindfulness") ?? true,
            "mindfulnessTime": UserDefaults.standard.string(forKey: "frequency") ?? "default frequency",
            "mindfulnessTopic": UserDefaults.standard.string(forKey: "themes") ?? "default theme",
            "dedicateTime": UserDefaults.standard.string(forKey: "time") ?? "default time",
            "extInfo": UserDefaults.standard.string(forKey: "comment") ?? "N/A"
            
        ]

        guard let jsonData = try? JSONSerialization.data(withJSONObject: profileData, options: []) else {
            print("Error: Cannot create JSON from profile data")
            return
        }

        request.httpBody = jsonData

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                // Check for network errors
                if let error = error {
                    print("Network error occurred: \(error.localizedDescription)")
                    // Optionally, show an alert to inform the user
                    self.showAlert(withTitle: "Network Error", message: "Please check your internet connection and try again.")
                    return
                }

                // Check the response code
                guard let httpResponse = response as? HTTPURLResponse else {
                    print("Unable to obtain HTTP response")
                    // Optionally, show an alert to inform the user
                    self.showAlert(withTitle: "Error", message: "Unexpected server response. Please try again later.")
                    return
                }

                guard (200...299).contains(httpResponse.statusCode) else {
                    print("Server returned an error: \(httpResponse.statusCode)")
                    // Optionally, show an alert with more details
                    self.showAlert(withTitle: "Error", message: "Server error occurred. Please try again later.")
                    return
                }

                // Ensure data is not nil
                guard let data = data else {
                    print("Server response data is nil")
                    // Optionally, show an alert to inform the user
                    self.showAlert(withTitle: "Error", message: "Invalid response from the server. Please try again.")
                    return
                }

                // Parse the JSON response
                do {
                    if let jsonResponse = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                        print("Server response: \(jsonResponse)")
                        // Handle the parsed JSON data here
                        // For example, check if the profile was successfully saved and then navigate to the main screen
                        DispatchQueue.main.async {
                            // Navigate to the main screen or perform another action based on the response
                            // For example: self.performSegue(withIdentifier: "showMainScreenSegue", sender: nil)
                        }
                    }
                } catch let error {
                    print("JSON parsing error: \(error.localizedDescription)")
                    // Optionally, show an alert to inform the user
                    self.showAlert(withTitle: "Error", message: "Failed to process server response. Please try again.")
                }
            }
        }

        task.resume()
        
    }
    
    func showAlert(withTitle title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alertController, animated: true)
    }

    

}
