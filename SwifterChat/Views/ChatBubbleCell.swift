//
//  ChatBubbleCell.swift
//  SwifterChat
//
//  Created by Harshita on 04/01/16.
//  Copyright © 2016 HC. All rights reserved.
//

import UIKit

class ChatBubbleCell: UITableViewCell {

    @IBOutlet var chatLabel: UILabel!
    @IBOutlet var timeStampLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
