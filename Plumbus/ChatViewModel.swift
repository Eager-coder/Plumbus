//
//  ChatViewModel.swift
//  Plumbus
//
//  Created by Kenes Yerassyl on 9/1/20.
//  Copyright © 2020 Kenes Yerassyl. All rights reserved.
//

import MessageKit

class ChatViewModel {
    var messages = [Message]()
    var sender = Sender(
        photoURL: "",
        senderId: UserDefaults.standard.value(forKey: "email") as? String ?? "",
        displayName: UserDefaults.standard.value(forKey: "name") as? String ?? ""
    )
    
    func getSender() -> SenderType {
        return sender
    }
    
    func getNumberOfMessages() -> Int { return messages.count }
    
    func getMessage(at section: Int) -> Message { return messages[section] }
}
