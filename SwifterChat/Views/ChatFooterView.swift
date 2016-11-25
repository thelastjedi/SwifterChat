//
//  ChatFooterView.swift
//  SwifterChat
//
//  Created by Harshita on 04/01/16.
//  Copyright © 2016 HC. All rights reserved.
//

import UIKit

protocol ChatFooterDelegate {
     /**
     Send message and update main message table
    - parameter message: `chatInputField` text
    */
    func sendChat(message : String)
}

class ChatFooterView: UITableViewCell {

    var delegate:ChatFooterDelegate?
    
    @IBOutlet var chatInputField: UITextField!
    @IBOutlet var sendButton: UIButton!
    
    @IBAction func sendAction(_ sender: AnyObject) {
        delegate?.sendChat(message: chatInputField.text!)
        chatInputField.text = ""
    }
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
        

}
