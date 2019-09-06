//
//  MessagesView.swift
//  WhatsAppSwiftUI
//
//  Created by Dino on 05/09/2019.
//  Copyright © 2019 Dino Srdoc. All rights reserved.
//

import Foundation
import SwiftUI

struct Message: Hashable, Identifiable {
    enum Sender: Hashable {
        case me
        case other(named: String)
    }
    
    let id = UUID()
    let sender: Sender
    let content: String
}

struct MessagesViews: View {
    @State var messages: [Message] = [
        .init(sender: .me, content: "Hi there! How's it going?"),
        .init(sender: .other(named: "Pero"), content: "Is ok bro")
    ]
    
    var body: some View {
        List(messages.reversed(), id: \.self) { message in
            GeometryReader { geometry in
                if message.sender == .me {
                    Text(message.content)
                        .rotationEffect(.radians(.pi))
                        .frame(maxWidth: geometry.size.width * 0.8)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(8)
                } else {
                    Text(message.content)
                        .rotationEffect(.radians(.pi))
                        .frame(maxWidth: geometry.size.width * 0.8)
                        .padding()
                        .background(Color.red)
                        .cornerRadius(8)
                }
            }.padding(.vertical, 24)
        }
        .rotationEffect(.radians(.pi))
    }
}
