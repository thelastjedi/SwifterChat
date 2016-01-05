//
//  ChatDataManager.swift
//  SwifterChat
//
//  Created by Harshita on 04/01/16.
//  Copyright © 2016 HC. All rights reserved.
//

import Foundation

class ChatDataManager {
    
    class ChatEntry {
        let chatMessage: NSString
        let timeStamp: NSDate
        let outgoingMessage: Bool
        let profilePicture : NSString
        
        init(chatMessage : NSString, outgoingMessage: Bool) {
            self.chatMessage = chatMessage
            self.outgoingMessage = outgoingMessage
            timeStamp = NSDate()
            profilePicture = outgoingMessage ? "Cross" : "Circle"
        }
        
    }
    
    var chatMessages = [ChatEntry(chatMessage: "A long time ago in a galaxy far, far away.", outgoingMessage: true),
        ChatEntry(chatMessage: "It is a period of civil war. Rebel spaceships, striking from a hidden base, have won their first victory against the evil Galactic Empire.", outgoingMessage: true),
        ChatEntry(chatMessage: "During the battle, Rebel spies managed to steal secret plans to the Empire's ultimate weapon, the DEATH STAR, an armored space station with enough power to destroy an entire planet.", outgoingMessage: true),
        ChatEntry(chatMessage: "Pursued by the Empire's sinister agents, Princess Leia races home aboard her starship, custodian of the stolen plans that can save her people and restore freedom to the galaxy", outgoingMessage: true),]
    
    
    func addNewChat(chatMessage : NSString, outgoingMessage: Bool) {
        chatMessages.append(ChatEntry(chatMessage: chatMessage, outgoingMessage: outgoingMessage))
    }
    
}
