//
//  ChatViewController.swift
//  Plumbus
//
//  Created by Kenes Yerassyl on 9/1/20.
//  Copyright © 2020 Kenes Yerassyl. All rights reserved.
//

import MessageKit



class ChatViewController: MessagesViewController {
    
    private let vm = ChatViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        // REMOVE
        vm.messages.append(Message(
            sender: vm.getSender(),
            messageId: "1",
            sentDate: Date(),
            kind: .text("Hello Negro"))
        )
        vm.messages.append(Message(
            sender: vm.getSender(),
            messageId: "1",
            sentDate: Date(),
            kind: .text("You be doing good?"))
        )
        
        messagesCollectionView.messagesDataSource = self
        messagesCollectionView.messagesDisplayDelegate = self
        messagesCollectionView.messagesLayoutDelegate = self
    }
    
}

extension ChatViewController: MessagesDataSource, MessagesDisplayDelegate, MessagesLayoutDelegate {
    func currentSender() -> SenderType {
        return vm.getSender()
    }
    
    func messageForItem(at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> MessageType {
        return vm.getMessage(at: indexPath.section)
    }
    
    func numberOfSections(in messagesCollectionView: MessagesCollectionView) -> Int {
        return vm.getNumberOfMessages()
    }
    
}
