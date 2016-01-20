//
//  ChatDataManager.swift
//  SwifterChat
//
//  Created by Harshita on 04/01/16.
//  Copyright © 2016 HC. All rights reserved.
//

import Foundation
import RealmSwift

class ChatDataManager {
    
    var messages = [Thought]()
    let realm = try! Realm()

    /**
     Return updated array
     */
    func thoughtArray() -> [Thought] {
        return Array(realm.objects(Thought))
    }
    /**
     Add new message to realm object array
     - parameter message: content of thought
     */
    func addNewThought(message : NSString) {
        let newThought = Thought()
        newThought.message =  message
        newThought.timeStamp =  NSDate()
        try! realm.write {
            realm.add(newThought)
        }
    }
    
}
