//
//  MessageTailView.swift
//  WhatsAppSwiftUI
//
//  Created by Dino on 09/09/2019.
//  Copyright © 2019 Dino Srdoc. All rights reserved.
//

import SwiftUI


struct MessageTailView: View {
    let sender: Message.Sender
    
    var body: some View {
        GeometryReader { geometry in
            Path { path in
                path.move(to: CGPoint(x: geometry.size.width * 0.15, y: 0))
                path.addQuadCurve(to: CGPoint(x: 0, y: geometry.size.height), control: CGPoint(x: geometry.size.width * 0.25, y: geometry.size.height * 0.5))
                path.addQuadCurve(to: CGPoint(x: geometry.size.width * 0.45, y: 0), control: CGPoint(x: geometry.size.width * 0.85, y: 0))
            }
            .fill(Color.red)
            .transformEffect(.init(scaleX: self.sender == .me ? -1 : 1, y: 1))
        }
    }
}

struct MessageTailView_Previews: PreviewProvider {
    static var previews: some View {
        MessageTailView(sender: .me)
    }
}
