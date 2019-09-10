//
//  MessageView.swift
//  WhatsAppSwiftUI
//
//  Created by Dino on 09/09/2019.
//  Copyright © 2019 Dino Srdoc. All rights reserved.
//

import SwiftUI

struct MessageView: View {
    let message: Message
    let shouldDrawTail: Bool
    
    private var activeBackgroundColor: Color {
        message.sender == .me ? Color("MessageBackgroundCurrentUser") : Color("MessageBackgroundOtherUser")
    }
    private var activeForegroundColor: Color {
        message.sender == .me ? Color("MessageForegroundCurrentUser") : Color("MessageForegroundOtherUser")
    }
    
    var body: some View {
        HStack {
            if message.sender == .me {
                Spacer()
            }
            
            VStack(alignment: message.sender == .me ? .trailing : .leading, spacing: 0) {
                Text(message.content)
                    .multilineTextAlignment(.leading)
                    .fixedSize(horizontal: false, vertical: true)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 4)
                    .background(activeBackgroundColor)
                    .foregroundColor(activeForegroundColor)
                    .cornerRadius(16)
                    .offset(x: message.sender == .me ? -4 : 4, y: 0)
                
                if shouldDrawTail {
                    MessageTailView(sender: message.sender) { self.activeBackgroundColor }
                        .frame(width: 20, height: 16, alignment: .leading)
                        .offset(x: 0, y: -8)
                }
            }
            
            if message.sender != .me {
                Spacer()
            }
        }
    }
}

struct MessageView_Previews: PreviewProvider {
    static var previews: some View {
        MessageView(message: Message.mock, shouldDrawTail: true)
    }
}
