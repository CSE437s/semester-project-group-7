//
//  JobQAViewController.swift
//  group_7
//
//  Created by Elysia Quah on 2/23/24.
//

import UIKit
import SwiftUI

class JobQAViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
}

struct DropdownMenuView: View {
    @State private var selectedItem = "Select Occupation"
    let occupations = ["Student", "Professional", "Freelancer", "Unemployed", "Other"]
    
    var body: some View {
        VStack {
            Text("Select Your Occupation")
                .font(.headline)
            
            Picker("Occupation", selection: $selectedItem) {
                ForEach(occupations, id: \.self) {
                    Text($0)
                }
            }
            .pickerStyle(MenuPickerStyle())
            .padding()
        }
    }
}

class DropdownMenuViewController: UIHostingController<DropdownMenuView> {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder, rootView: DropdownMenuView())
    }
}
