//
//  ContentView.swift
//  WhatsAppSwiftUI
//
//  Created by Dino on 05/09/2019.
//  Copyright © 2019 Dino Srdoc. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State var messages: [Message] = {
        let decoder = JSONDecoder()
        let data = allMessagesString.data(using: .utf8)!
        return try! decoder.decode([Message].self, from: data)
    }()

    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                MessageListView(messages: messages)
                    .navigationBarTitle("Johnny Appleseed", displayMode: .automatic)
                
                VStack(spacing: 0) {
                    Rectangle()
                        .fill(Color.gray.opacity(0.2))
                        .frame(height: 1)
                        .shadow(radius: 4)
                    
                    MessageInputView() { enteredText in
                        let id = (self.messages.map { $0.id }.max() ?? 0) + 1
                        let message = Message(id: id, sender: .me, content: enteredText)
                        self.messages.append(message)
                    }
                    
                    Rectangle()
                        .fill(Color.white)
                        .frame(height: 44)
                }
            }
            .edgesIgnoringSafeArea(.bottom)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

let allMessagesString = """
[
    {
        "id": 0,
        "content": "Hi there John!",
        "sender": "me"
    },
    {
        "id": 1,
        "content": "Hello.",
        "sender": "John"
    },
    {
        "id": 2,
        "content": "What's for dinner tomorrow? I've been thinking about making some triple layered apple pie with the Golden Smiths that Jonathan has given us.",
        "sender": "me"
    },
    {
        "id": 3,
        "content": "How about some fried apples?",
        "sender": "John"
    }
]

"""
