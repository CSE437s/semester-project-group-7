//
//  JobQAViewController.swift
//  group_7
//

import UIKit
import SwiftUI

class JobQAViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    let occupations = [nil, "Student", "Professional", "Freelancer", "Unemployed", "Other"]
    var selectedOccupation: String?
    
    @IBOutlet weak var pickerView: UIPickerView!
    override func viewDidLoad() {
        super.viewDidLoad()
        pickerView.dataSource = self
        pickerView.delegate = self
        
    }
    
    @IBAction func nextButtonTapped(_ sender: UIButton) {
        // Ensure an occupation has been selected
        guard let occupation = selectedOccupation else {
                showAlert(withMessage: "Please select an occupation to proceed.")
                return
            }
        
        UserDefaults.standard.set(occupation, forKey: "occupation")
    }
    
    func showAlert(withMessage message: String) {
        let alert = UIAlertController(title: "Selection Required", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }


    // 实现UIPickerViewDataSource协议方法
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        // 返回选择器的列数
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        // 返回每列的行数
        return occupations.count
    }

    // 实现UIPickerViewDelegate协议方法
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return occupations[row]
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        // 当用户选择某一行时执行的操作
        selectedOccupation = occupations[row]
    }
    
}
