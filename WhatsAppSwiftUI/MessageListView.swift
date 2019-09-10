//
//  MessageListView.swift
//  WhatsAppSwiftUI
//
//  Created by Dino on 05/09/2019.
//  Copyright © 2019 Dino Srdoc. All rights reserved.
//

import Foundation
import SwiftUI

struct MessageListView: View {
    let messages: [Message]
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView(.vertical, showsIndicators: false) {
                ForEach(self.messages) { message in
                    MessageView(message: message, shouldDrawTail: self.shouldDrawTail(for: message))
                        .padding(.horizontal, 8)
                        .padding(self.paddingInsets(for: message, geometry: geometry))
                }
            }
        }
    }
    
    private func shouldDrawTail(for message: Message) -> Bool {
        let currentMessageIndex = self.messages.firstIndex(of: message)
        let nextMessageIndex = currentMessageIndex.flatMap { self.messages.index($0, offsetBy: 1, limitedBy: self.messages.count - 1) }
        let isNextSenderSameAsCurrent = nextMessageIndex.map { self.messages[$0] }?.sender == message.sender
        
        return !isNextSenderSameAsCurrent
    }
    
    private func paddingInsets(for message: Message, geometry: GeometryProxy) -> EdgeInsets {
        let top: CGFloat
        let bottom: CGFloat
        
        let currentMessageIndex = self.messages.firstIndex(of: message)
        let nextMessageIndex = currentMessageIndex.flatMap { self.messages.index($0, offsetBy: 1, limitedBy: self.messages.count - 1) }
        let previousMessageIndex = currentMessageIndex.flatMap { self.messages.index($0, offsetBy: -1, limitedBy: 0) }
        let isPreviousSenderSameAsCurrent = previousMessageIndex.map { self.messages[$0] }?.sender == message.sender
        let isNextSenderSameAsCurrent = nextMessageIndex.map { self.messages[$0] }?.sender == message.sender
        
        if isPreviousSenderSameAsCurrent {
            top = -3
        } else {
            top = 0
        }
        
        if isNextSenderSameAsCurrent {
            bottom = -3
        } else {
            bottom = 0
        }
        
        return EdgeInsets(top: top, leading: 0, bottom: bottom, trailing: 0)

    }

}
