//
//  TableDataSource.swift
//  SwifterChat
//
//  Created by Harshita on 05/01/16.
//  Copyright © 2016 HC. All rights reserved.
//

import Foundation
import UIKit

class TableDataSource: NSObject, UITableViewDataSource, UITableViewDelegate {
    
    let chatData = ChatDataManager()

    var stubData = [Thought]()
    
    //For tableFooterView delegate
    var parentViewRef:TableViewController?

    
    // MARK: -
    

    /**
    Refresh messages
    */
    func refreshDataSource() {
        stubData = chatData.thoughtArray()
    }
    
    
    func insertNewThought(_ message: String) {
        print("adding new message: \(message)")
        chatData.addNewThought(message)
        refreshDataSource()
    }
    

    // MARK: - UITableView data source
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stubData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ChatBubbleCellIdentifier, for: indexPath) as! ChatBubbleCell
        let thought = stubData[indexPath.row]
        cell.chatLabel.text = thought.message as String
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .short
        cell.timeStampLabel.text = dateFormatter.string(from: thought.timeStamp)
        return cell
    }
    
    
    // MARK: - UITableView delegate
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        let thought = stubData[indexPath.row]
        
        if thought.messageHeight != 0 {
            return thought.messageHeight;
        }

        let sizingCell = tableView.dequeueReusableCell(withIdentifier: ChatBubbleCellIdentifier) as! ChatBubbleCell
        let chat = stubData[indexPath.row]
        sizingCell.chatLabel.text = chat.message as String
        sizingCell.setNeedsLayout()
        sizingCell.layoutIfNeeded()
        let height = sizingCell.contentView.systemLayoutSizeFitting(UILayoutFittingCompressedSize).height;
        try! chatData.realm.write {
            thought.messageHeight = height
        }

        return height;
    }

    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let cell = tableView.dequeueReusableCell(withIdentifier: ChatFooterIdentifier) as! ChatFooterView
        cell.delegate = parentViewRef
        cell.autoresizingMask = .flexibleWidth
        let footerView = UIView(frame: cell.frame)
        footerView.addSubview(cell)
        return footerView
    }
    
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 71
    }

}
