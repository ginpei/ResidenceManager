//
//  ChatThread.swift
//  ResidenceManager
//
//  Created by Ginpei on 2017-07-13.
//  Copyright © 2017 Ginpei. All rights reserved.
//

import Foundation
import Firebase

class ChatThread {
    var messages = [ChatMessage]()
    
    var lastMessage: ChatMessage? {
        get {
            return messages.last
        }
    }
}

enum ChatThreadResult {
    case success([ChatThread])
    case failure(Error?)
}

class ChatThreadStore {
    func fetchAll(completionHandler: @escaping (ChatThreadResult) -> Void) {
        // dummy
        
        Timer.scheduledTimer(withTimeInterval: 0.7, repeats: false) { timer in
            let thread1 = ChatThread()
            thread1.messages = [ChatMessage(body: "hello whats up")]
            let thread2 = ChatThread()
            thread2.messages = [ChatMessage(body: "PAY ME ASAP")]
            let thread3 = ChatThread()
            thread3.messages = [ChatMessage(body: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.")]
            
            let result = ChatThreadResult.success([thread1, thread2, thread3])
            completionHandler(result)
        }
    }
}
