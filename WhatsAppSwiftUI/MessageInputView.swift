//
//  MessageInputView.swift
//  WhatsAppSwiftUI
//
//  Created by Dino on 11/09/2019.
//  Copyright © 2019 Dino Srdoc. All rights reserved.
//

import SwiftUI

struct MessageInputView: View {
    @State private var input = ""
    let onCommit: (String) -> Void
    
    var body: some View {
        ZStack {
            TextField("Say Hello!", text: $input) {
                self.onCommit(self.input)
                self.input = ""
            }
                .padding()
                .cornerRadius(8)
        }
    }
}

struct MessageInputView_Previews: PreviewProvider {
    static var previews: some View {
        MessageInputView(onCommit: { _ in })
    }
}
