//
//  CheckboxListViewII.swift
//  group_7
//

import SwiftUI


struct CheckboxListViewII: View {
    @State var inputList2: [CheckItem] = arr2.map { str in
        return CheckItem(title: str, state: false)
    }
    

    var body: some View {
        List {
            ForEach(0..<inputList2.count, id: \.self) { index in
                CheckboxRowII(checked: self.$inputList2[index].state, index: index, text: "\(inputList2[index].title)")
            }
        }
    }
}

struct CheckboxRowII: View {
    @Binding var checked: Bool
    var index: Int
    var text: String

    var body: some View {
        HStack {
            CheckboxViewII(checked: $checked, index: index)
            Text(text)
        }
    }
}

struct CheckboxViewII: View {
    @Binding var checked: Bool
    var index: Int
    var body: some View {
        Button(action: {
            self.checked.toggle()
            globalCheckboxData2[index].state = self.checked
            NSLog(globalCheckboxData2[index].title, globalCheckboxData2[index].state)
        }) {
            Image(systemName: checked ? "checkmark.square.fill" : "square")
                .resizable()
                .frame(width: 20, height: 20)
        }
    }
}
