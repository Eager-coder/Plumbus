//
//  ChatViewModel.swift
//  Plumbus
//
//  Created by Kenes Yerassyl on 9/1/20.
//  Copyright © 2020 Kenes Yerassyl. All rights reserved.
//

class ChatViewModel {
    var messages = [Message]()
    var sender = Sender(photoURL: "", senderId: "1", displayName: "Kenes Yerassyl")
    
    func getSender() -> Sender { return sender }
    
    func getNumberOfMessages() -> Int { return messages.count }
    
    func getMessage(at section: Int) -> Message { return messages[section] }
}
