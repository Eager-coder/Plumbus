//
//  ChatViewController.swift
//  Plumbus
//
//  Created by Kenes Yerassyl on 9/1/20.
//  Copyright © 2020 Kenes Yerassyl. All rights reserved.
//

import MessageKit
import InputBarAccessoryView


class ChatViewController: MessagesViewController {
    
    public var isNewConversation = false
    public var otherUserEmail: String
    
    private let vm = ChatViewModel()
    
    init(with email: String) {
        self.otherUserEmail = email
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
        messageInputBar.delegate = self
    }
    
}

extension ChatViewController: InputBarAccessoryViewDelegate {
    func inputBar(_ inputBar: InputBarAccessoryView, didPressSendButtonWith text: String) {
        guard !text.replacingOccurrences(of: " ", with: "").isEmpty else { return }
        if isNewConversation {
            // create in DB
        } else {
            // append existing one
        }
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
