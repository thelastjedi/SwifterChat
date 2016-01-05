//
//  ChatFooterView.swift
//  SwifterChat
//
//  Created by Harshita on 04/01/16.
//  Copyright © 2016 HC. All rights reserved.
//

import UIKit

protocol ChatFooterDelegate {
    func sendChat(chatMessage : NSString)
}

class ChatFooterView: UITableViewCell {

    var delegate:ChatFooterDelegate?
    
    @IBOutlet var chatInputField: UITextField!
    @IBOutlet var sendButton: UIButton!
    
    @IBAction func sendAction(sender: AnyObject) {
        delegate?.sendChat(chatInputField.text!)
        chatInputField.text = ""
    }
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
        

}
