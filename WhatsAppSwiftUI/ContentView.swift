//
//  ContentView.swift
//  WhatsAppSwiftUI
//
//  Created by Dino on 05/09/2019.
//  Copyright © 2019 Dino Srdoc. All rights reserved.
//

import SwiftUI

var messages: [Message] = {
    let decoder = JSONDecoder()
    let data = allMessagesString.data(using: .utf8)!
    return try! decoder.decode([Message].self, from: data)
}()

struct ContentView: View {
    var body: some View {
        MessagesViews(messages: messages)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

let allMessagesString = """
[
    {
        "id": 0,
        "content": "Foo bar",
        "sender": "me"
    },
    {
        "id": 1,
        "content": "Foo bar? FOOOOOO! Bar?!?!",
        "sender": "Pero"
    },
    {
        "id": 2,
        "content": "Baz quuz. Foo. Bar foo bar bar foo quux. Foo bar. Bar?",
        "sender": "me"
    },
    {
        "id": 3,
        "content": "Bar bar bar bar bar. Foo! Bar? Foo bar foo foo quux. Foo. Foobar.",
        "sender": "Pero"
    },
    {
        "id": 4,
        "content": "bar bar bar...",
        "sender": "me"
    },
    {
        "id": 5,
        "content": "bar bar bar....... Fooooo",
        "sender": "Pero"
    },
    {
        "id": 6,
        "content": "Foobar bar foo bar?",
        "sender": "me"
    },
    {
        "id": 7,
        "content": "fooooofoooooooo",
        "sender": "me"
    },
    {
        "id": 8,
        "content": "quux bar bax xab rab fooo foo oooooooooo",
        "sender": "me"
    },
    {
        "id": 9,
        "content": "Foo. Foo foo foo.",
        "sender": "Pero"
    },
    {
        "id": 10,
        "content": "Foobar quux foobar foo bar bar bar foo.",
        "sender": "me"
    },
    {
        "id": 11,
        "content": "bar bar foo",
        "sender": "Pero"
    },
    {
        "id": 12,
        "content": "foo",
        "sender": "me"
    }
]

"""
