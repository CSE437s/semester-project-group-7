//
//  FrequencyQAViewController.swift
//  group_7
//
//  Created by Noah Li on 2024/3/19.
//

import UIKit
import SwiftUI

class FrequencyQAViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    let frequency = [nil, "Couple times a week", "About once a week", "A few times a month", "Once a month", "Ocasionally", "Almost never"]
    var selectedFrequency: String?
    
    @IBOutlet weak var pickerView: UIPickerView!
    override func viewDidLoad() {
        super.viewDidLoad()
        pickerView.dataSource = self
        pickerView.delegate = self
        
        // Create a Next button and set up its constraints or position
        let nextButton = UIButton(type: .system)
        nextButton.setTitle("Next", for: .normal)
        nextButton.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
    }
    
    @IBAction func nextButtonTapped(_ sender: UIButton) {
        // Ensure an occupation has been selected
        guard let occupation = selectedFrequency else {
                showAlert(withMessage: "Please select a frequency.")
                return
            }
        
        UserDefaults.standard.set(occupation, forKey: "frequency")
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
        return frequency.count
    }

    // 实现UIPickerViewDelegate协议方法
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return frequency[row]
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        // 当用户选择某一行时执行的操作
        selectedFrequency = frequency[row]
    }
}
