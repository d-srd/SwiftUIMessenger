//
//  MessagesView.swift
//  WhatsAppSwiftUI
//
//  Created by Dino on 05/09/2019.
//  Copyright © 2019 Dino Srdoc. All rights reserved.
//

import Foundation
import SwiftUI

struct Message: Hashable, Identifiable, Decodable {
    enum Sender: Hashable {
        case me
        case other(named: String)
    }
    
    private enum CodingKeys: String, CodingKey {
        case id
        case sender
        case content
    }
    
    let id: Int
    let sender: Sender
    let content: String
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        content = try container.decode(String.self, forKey: .content)
        
        let senderString = try container.decode(String.self, forKey: .sender)
        if senderString == "me" {
            sender = .me
        } else {
            sender = .other(named: senderString)
        }
    }
}

struct MessageTailView: View {
    var body: some View {
        GeometryReader { geometry in
            Path { path in
                path.move(to: CGPoint(x: geometry.size.width * 0.15, y: 0))
                path.addQuadCurve(to: CGPoint(x: 0, y: geometry.size.height), control: CGPoint(x: geometry.size.width * 0.25, y: geometry.size.height * 0.5))
                path.addQuadCurve(to: CGPoint(x: geometry.size.width * 0.45, y: 0), control: CGPoint(x: geometry.size.width * 0.85, y: 0))
            }.fill(Color.red)
        }
    }
}

struct MessagesViews: View {
    @State var messages: [Message] = [
        .init(sender: .me, content: "Hi there! How's it going?"),
        .init(sender: .other(named: "Pero"), content: "Is ok bro. How bout everything going on with u and ur all of the bestest most famous all of them yes quite it must be very yodling to be about it"),
        .init(sender: .me, content: "E moj Pero da je Pero biti lako Pero")
    ]
    
    var body: some View {
        ScrollView {
            ForEach(messages.reversed()) { message in
                GeometryReader { geometry in
                    if message.sender == .me {
                        Text(message.content)
                            .fixedSize(horizontal: false, vertical: true)
                            .rotationEffect(.radians(.pi))
                        .padding()
                            .background(Color.blue)
                            .cornerRadius(8)
                    } else {
                        ZStack(alignment: .trailing) {
                            MessageTailView()
                                .rotationEffect(.radians(.pi))
                                .frame(width: 20, height: 20, alignment: .trailing)
                                .offset(x: 0, y: -20)

                            Text(message.content)
                                .fixedSize(horizontal: false, vertical: true)
                                .rotationEffect(.radians(.pi))
                            .padding()
//                                .padding(.vertical, 2)
//                                .padding(.horizontal, 4)
                                .background(Color.red)
                                .cornerRadius(8)
                                .offset(x: 6, y: 0)
                        }
                    }
                }.padding(EdgeInsets(top: 40, leading: 14, bottom: 20, trailing: 14))

            }
        }
        .rotationEffect(.radians(.pi))
    }
}
