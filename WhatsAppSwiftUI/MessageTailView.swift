//
//  MessageTailView.swift
//  WhatsAppSwiftUI
//
//  Created by Dino on 09/09/2019.
//  Copyright © 2019 Dino Srdoc. All rights reserved.
//

import SwiftUI

struct MessageTailView<Background: ShapeStyle>: View {
    let sender: Message.Sender
    let backgroundFill: Background
    
    init(sender: Message.Sender, background: () -> Background) {
        self.sender = sender
        self.backgroundFill = background()
    }
    
    var body: some View {
        GeometryReader { geometry in
            Path { path in
                let origin: CGPoint
                let curveOnePoint: CGPoint
                let curveOneControl: CGPoint
                let curveTwoPoint: CGPoint
                let curveTwoControl: CGPoint
                
                if self.sender == .me {
                    origin = CGPoint(x: geometry.size.width * 0.65, y: 0)
                    curveOnePoint = CGPoint(x: geometry.size.width, y: geometry.size.height)
                    curveOneControl = CGPoint(x: geometry.size.width * 0.75, y: geometry.size.height * 0.75)
                    curveTwoPoint = CGPoint(x: geometry.size.width * 0.25, y: 0)
                    curveTwoControl = CGPoint(x: geometry.size.width * 0.15, y: geometry.size.height * 0.25)
                } else {
                    origin = CGPoint(x: geometry.size.width * 0.35, y: 0)
                    curveOnePoint = CGPoint(x: 0, y: geometry.size.height)
                    curveOneControl = CGPoint(x: geometry.size.width * 0.25, y: geometry.size.height * 0.75)
                    curveTwoPoint = CGPoint(x: geometry.size.width * 0.75, y: 0)
                    curveTwoControl = CGPoint(x: geometry.size.width * 0.85, y: geometry.size.height * 0.25)
                }
                
                path.move(to: origin)
                path.addQuadCurve(to: curveOnePoint, control: curveOneControl)
                path.addQuadCurve(to: curveTwoPoint, control: curveTwoControl)
            }
            .fill(self.backgroundFill)
        }
    }
}

struct MessageTailView_Previews: PreviewProvider {
    static var previews: some View {
        MessageTailView(sender: .me) {
            Color.blue
        }
    }
}
