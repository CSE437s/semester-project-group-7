//
//  CheckBoxListThemeView.swift
//  group_7
//
//  Created by Noah Li on 2024/3/19.
//

import SwiftUI




struct CheckboxListThemeView: View {
    @State var inputList: [CheckItem] = arr2.map { str in
        return CheckItem(title: str, state: false)
    }
    
//    @State private var checkedItems: [Bool]

    var body: some View {
        
        List {
            ForEach(0..<inputList.count, id: \.self) { index in
                CheckboxRow(checked: self.$inputList[index].state, index: index, text: "\(inputList[index].title)")
            }
        }

    }
}




#Preview {
    CheckboxListView()
}

