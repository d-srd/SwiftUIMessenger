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
        .init(sender: .other(named: "Pero"), content: "Is ok bro"),
        .init(sender: .me, content: "E moj Pero da je Pero biti lako Pero")
    ]
    
    var body: some View {
        ScrollView {
            ForEach(messages.reversed()) { message in
                GeometryReader { geometry in
                    if message.sender == .me {
                        Text(message.content)
                            .rotationEffect(.radians(.pi))
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(8)
                            .frame(minWidth: 0, maxWidth: geometry.size.width, alignment: .leading)
                    } else {
                        Text(message.content)
                            .rotationEffect(.radians(.pi))
    //                        .frame(maxWidth: geometry.size.width * 0.8)
                            .padding()
                            .background(Color.red)
                            .cornerRadius(8)
                            .frame(minWidth: 0, maxWidth: geometry.size.width, alignment: .trailing)
    //                        .offset(x: geometry.size.width * 0.5, y: 0)
                    }
                }.padding(EdgeInsets(top: 40, leading: 16, bottom: 20, trailing: 16))

            }
        }
        .rotationEffect(.radians(.pi))
    }
}
