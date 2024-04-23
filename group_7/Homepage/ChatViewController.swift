//
//  ChatViewController.swift
//  group_7
//
//  Created by Elysia Quah on 4/16/24.
//

//import OpenAISwift
import UIKit
import AVFoundation
import SwiftUI

class ChatViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Create an instance of ChatViewController SwiftUI view
        let chatView = ContentView()
        
        // Create a UIHostingController with the SwiftUI view
        let hostingController = UIHostingController(rootView: chatView)
        
        // Add the hosting controller as a child view controller
        addChild(hostingController)
        view.addSubview(hostingController.view)
        hostingController.didMove(toParent: self)
        
        // Set constraints for the hosting controller's view to fill the parent view
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            hostingController.view.topAnchor.constraint(equalTo: view.topAnchor),
            hostingController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            hostingController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            hostingController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

struct ContentView: View {
    @State private var messageText = ""
    @State var messages: [String] = ["Welcome to Active Chat!"]
    
    var body: some View {
        VStack {
            HStack {
                Text("Active Chat")
                    .font(.title)
                    .bold()
                
                Image(systemName: "bubble.left.fill")
                    .font(.system(size: 26))
                    .foregroundColor(Color.yellow)
            }
            
            ScrollView {
                ForEach(messages, id: \.self) { message in
                    // If the message contains [USER], that means it's us
                    if message.contains("[USER]") {
                        let newMessage = message.replacingOccurrences(of: "[USER]", with: "")
                        
                        // User message styles
                        HStack {
                            Spacer()
                            Text(newMessage)
                                .padding()
                                .foregroundColor(Color.black)
                                .background(Color.white)
                                .cornerRadius(10)
                                .padding(.horizontal, 16)
                                .padding(.bottom, 10)
                        }
                    } else {
                        
                        // Bot message styles
                        HStack {
                            Text(message)
                                .padding()
                                .foregroundColor(Color.white)
                                .background(Color.accentColor)
                                .cornerRadius(10)
                                .padding(.horizontal, 16)
                                .padding(.bottom, 10)
                            Spacer()
                        }
                    }
                    
                }.rotationEffect(.degrees(180))
            }
            .rotationEffect(.degrees(180))
            .background(Color(red: 255/255, green: 248/255, blue: 201/255, opacity: 1))
            
            
            // Contains the Message bar
            HStack {
                TextField("Type something", text: $messageText)
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(10)
                    .onSubmit {
                        sendMessage(message: messageText)
                    }

                Button {
                    sendMessage(message: messageText)
                } label: {
                    Image(systemName: "paperplane.fill")
                        .foregroundColor(Color.accentColor)
                }
                .font(.system(size: 26))
                .padding(.horizontal, 10)
            }
            .padding()
            .background(Color.white)
        }.background(Color.accentColor)
    }
    
    func sendMessage(message: String) {
        withAnimation {
            messages.append("[USER]" + message)
            self.messageText = ""
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                withAnimation {
                    messages.append(getBotResponse(message: message))
                }
            }
        }
    }
}

func getBotResponse(message: String) -> String {
    let tempMessage = message.lowercased()

    if tempMessage.contains("hello") || tempMessage.contains("hi ") {
        return "Hello! It’s great to hear from you. How are you feeling right now?"
    } else if tempMessage.contains("goodbye") || tempMessage.contains("see you") {
        return "Take care! Remember, I'm always here if you need someone to talk to."
    }

    if tempMessage.contains("how are you") {
        return "Thanks for asking! I'm here to support you. What’s on your mind today?"
    }

    if tempMessage.contains("sad") || tempMessage.contains("depressed") || tempMessage.contains("down") || tempMessage.contains("not ok") {
        return "I'm sorry to hear you're feeling down. Want to share what’s been troubling you?"
    } else if tempMessage.contains("anxious") || tempMessage.contains("nervous") || tempMessage.contains("stressed") {
        return "Anxiety can be really tough to deal with. What’s been making you feel anxious?"
    } else if tempMessage.contains("happy") || tempMessage.contains("joyful") || tempMessage.contains("good") {
        return "It's great to see you happy! What’s been bringing you joy lately?"
    } else if tempMessage.contains("tired") || tempMessage.contains("exhausted") || tempMessage.contains("drained") {
        return "Rest is important. Has it been a long day for you? Want to talk about it?"
    } else if tempMessage.contains("angry") || tempMessage.contains("frustrated") || tempMessage.contains("mad") {
        return "It sounds like you're feeling frustrated. What happened that made you feel this way?"
    }

    if tempMessage.contains("yes") || tempMessage.contains("sure") || tempMessage.contains("ok") {
        return "Thanks for sharing that with me. Could you tell me a bit more about it?"
    } else if tempMessage.contains("no") || tempMessage.contains("not really") {
        return "That's okay. Feel free to share whatever you’re comfortable with when you’re ready."
    }

    if tempMessage.contains("lonely") || tempMessage.contains("alone") {
        return "Feeling lonely can be really hard. Would you like to talk about what’s been on your mind?"
    } else if tempMessage.contains("scared") || tempMessage.contains("fear") || tempMessage.contains("frightened") {
        return "That sounds scary. Would you like to share what’s frightening you?"
    } else if tempMessage.contains("overwhelmed") {
        return "It seems like you’re under a lot of stress. What’s on your plate right now?"
    }

    if tempMessage.contains("help") {
        return "I’m here to help. What do you need support with right now?"
    } else if tempMessage.contains("love") || tempMessage.contains("relationship") {
        return "Love is a powerful emotion. Are you feeling happy or challenged with your relationships?"
    } else if tempMessage.contains("no one understands") || tempMessage.contains("misunderstood") {
        return "Feeling misunderstood can be really isolating. Tell me more about what you’re going through."
    } else {
        return "I want to understand better. Can you tell me more or try asking another way?"
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

//attempt with openai
//final class APICaller {
//    static let shared = APICaller()
//    
//    @frozen enum Constants {
//        static let key = "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"
//    }
//    
//    private var client: OpenAISwift?
//    
//    private init() {}
//    
//    public func setup() {
//        self.client = OpenAISwift(config: OpenAISwift.Config.makeDefaultOpenAI(apiKey: Constants.key))
//    }
//    
//    public func getResponse(input: String,
//                            completion: @escaping (Result<String, Error>) -> Void) {
//        client?.sendCompletion(with: input, model: .gpt4(.gpt4), maxTokens: 50, completionHandler: {result in
//            switch result {
//            case .success(let model):
//                print(model.choices?.first?.text ?? "")
//                let output = model.choices?.first?.text ?? ""
//                completion(.success(output))
//            case .failure(let error):
//                completion(.failure(error))
//            }
//        })
//    }
//}

//class ChatViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate {
//    private let field: UITextField = {
//        let textField = UITextField()
//        textField.placeholder = "Type here..."
//        textField.translatesAutoresizingMaskIntoConstraints = false
//        textField.backgroundColor = .yellow
//        textField.returnKeyType = .done
//        return textField
//    }()
//    
//    private var models = [String]()
//    
//    private let table: UITableView = {
//        let table = UITableView()
//        table.translatesAutoresizingMaskIntoConstraints = false
//        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
//        return table
//    }()
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        view.addSubview(field)
//        view.addSubview(table)
//        field.delegate = self
//        table.delegate = self
//        table.dataSource = self
//        view.addSubview(field)
//        NSLayoutConstraint.activate([
//            field.heightAnchor.constraint(equalToConstant: 50),
//            field.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 10),
//            field.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -10),
//            field.bottomAnchor.constraint(equalTo: view.keyboardLayoutGuide.topAnchor),
//            
//            table.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
//            table.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
//            table.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
//            table.bottomAnchor.constraint(equalTo: field.topAnchor),
//        ])
//    }
//    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return models.underestimatedCount
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
//        cell.textLabel?.text = models[indexPath.row]
//        cell.textLabel?.numberOfLines = 0
//        return cell
//    }
//    
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        if let text = textField.text, !text.isEmpty {
//            models.append(text)
//            APICaller.shared.getResponse(input: text) { result in
//                switch result {
//                case .success(let output):
//                    self.models.append(output)
//                    DispatchQueue.main.async {
//                        self.table.reloadData()
//                        self.field.text = nil
//                    }
//                case .failure:
//                    print("Failed")
//                }
//            }
//        }
//        return true
//    }
//}
