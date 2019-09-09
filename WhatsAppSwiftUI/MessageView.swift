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
                .background(message.sender == .me ? Color.accentColor.opacity(0.7) : Color.gray.opacity(0.4))
                .cornerRadius(16)
            
            if message.sender != .me {
                Spacer()
            }
        }
    }
}

struct MessageView_Previews: PreviewProvider {
    static var previews: some View {
        MessageView(message: Message.mock)
    }
}
