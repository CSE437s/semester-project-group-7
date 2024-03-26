//
//  CheckboxListView.swift
//  group_7
//
//  Created by yunxijun on 2024/2/29.
//

import SwiftUI


struct CheckItem
{
    var title: String
    var state: Bool
}


struct CheckboxListView: View {
    @State var inputList: [CheckItem] = arr.map { str in
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

struct CheckboxRow: View {
    @Binding var checked: Bool
    var index: Int
    var text: String

    var body: some View {
        HStack {
            CheckboxView(checked: $checked, index: index)
            Text(text)
        }
    }
}

struct CheckboxView: View {
    @Binding var checked: Bool
    var index: Int
    var body: some View {
        Button(action: {
            self.checked.toggle()
            globalCheckboxData[index].state = self.checked
            NSLog(globalCheckboxData[index].title, globalCheckboxData[index].state)
        }) {
            Image(systemName: checked ? "checkmark.square.fill" : "square")
                .resizable()
                .frame(width: 20, height: 20)
        }
    }
}
