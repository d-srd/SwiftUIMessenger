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

struct MessageView: View {
    let message: Message
    
    var body: some View {
        HStack {
            if message.sender == .me {
                Spacer()
            }
            
            Text(message.content)
                .multilineTextAlignment(.leading)
                .fixedSize(horizontal: false, vertical: true)
                .padding(.horizontal, 12)
                .padding(.vertical, 4)
                .background(message.sender == .me ? Color.gray : Color.accentColor)
                .cornerRadius(16)
            
            if message.sender != .me {
                Spacer()
            }
        }
    }
}

struct MessagesViews: View {
    let messages: [Message]
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView(.vertical, showsIndicators: false) {
                ForEach(self.messages.reversed()) { message in
                    MessageView(message: message)
                        .padding(.horizontal, 8)
                        .padding(EdgeInsets(top: 0, leading: message.sender == .me ? geometry.size.width * 0.3 : 0, bottom: 0, trailing: message.sender != .me ? geometry.size.width * 0.3 : 0))
                }
            }
        }
    }
}
