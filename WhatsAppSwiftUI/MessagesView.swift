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
                .background(message.sender == .me ? Color.gray.opacity(0.7) : Color.accentColor.opacity(0.7))
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
                        .padding(self.paddingInsets(for: message, geometry: geometry))
                }
            }
        }
    }
    
    private func paddingInsets(for message: Message, geometry: GeometryProxy) -> EdgeInsets {
        let top: CGFloat
        let leading: CGFloat
        let bottom: CGFloat
        let trailing: CGFloat
        
        let currentMessageIndex = self.messages.firstIndex(of: message)
        let nextMessageIndex = currentMessageIndex.flatMap { self.messages.index($0, offsetBy: 1, limitedBy: self.messages.count - 1) }
        let previousMessageIndex = currentMessageIndex.flatMap { self.messages.index($0, offsetBy: -1, limitedBy: 0) }
        let isPreviousSenderSameAsCurrent = previousMessageIndex.map { self.messages[$0] }?.sender == message.sender
        let isNextSenderSameAsCurrent = nextMessageIndex.map { self.messages[$0] }?.sender == message.sender
        let isCurrentUserSender = message.sender == .me
        
        if isPreviousSenderSameAsCurrent {
            top = -4
        } else {
            top = 0
        }
        
        if isCurrentUserSender {
            leading = geometry.size.width * 0.3
        } else {
            leading = 0
        }
        
        if isNextSenderSameAsCurrent {
            bottom = -4
        } else {
            bottom = 0
        }
        
        if isCurrentUserSender == false {
            trailing = geometry.size.width * 0.3
        } else {
            trailing = 0
        }
        
        return EdgeInsets(top: top, leading: leading, bottom: bottom, trailing: trailing)

    }

}
