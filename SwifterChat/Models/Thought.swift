//
//  Thought.swift
//  SwifterChat
//
//  Created by Harshita on 20/01/16.
//  Copyright © 2016 HC. All rights reserved.
//

import RealmSwift

class Thought: Object {
    dynamic var message = ""
    dynamic var timeStamp = Date()
    dynamic var messageHeight : CGFloat = 0
}
