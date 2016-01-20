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
    var cellHeight: [CGFloat] = []
    
    
    //For tableFooterView delegate
    var parentViewRef:TableViewController?

    
    // MARK: -
    

    /**
    Refresh messages
    */
    func refreshDataSource() {
        stubData = chatData.thoughtArray()
    }
    
    
    func insertNewThought(message: NSString) {
        print("adding new message: \(message)")
        chatData.addNewThought(message)
        refreshDataSource()
    }
    

    // MARK: - UITableView data source
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stubData.count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(ChatBubbleCellIdentifier, forIndexPath: indexPath) as! ChatBubbleCell
        let thought = stubData[indexPath.row]
        cell.chatLabel.text = thought.message as String
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateStyle = .ShortStyle
        dateFormatter.timeStyle = .ShortStyle
        cell.timeStampLabel.text = dateFormatter.stringFromDate(thought.timeStamp) as String
        return cell
    }
    
    
    // MARK: - UITableView delegate
    
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {

        //use cached cell height to improve performance
        if cellHeight.count > indexPath.row {
            return cellHeight[indexPath.row]
        }
        
        let sizingCell = tableView.dequeueReusableCellWithIdentifier(ChatBubbleCellIdentifier) as! ChatBubbleCell
        let chat = stubData[indexPath.row]
        sizingCell.chatLabel.text = chat.message as String
        sizingCell.setNeedsLayout()
        sizingCell.layoutIfNeeded()
        let height = sizingCell.contentView.systemLayoutSizeFittingSize(UILayoutFittingCompressedSize).height;
        cellHeight.append(height)
        return height;
    }

    
    func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let cell = tableView.dequeueReusableCellWithIdentifier(ChatFooterIdentifier) as! ChatFooterView
        cell.delegate = parentViewRef
        cell.autoresizingMask = .FlexibleWidth
        let footerView = UIView(frame: cell.frame)
        footerView.addSubview(cell)
        return footerView
    }
    
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 71
    }

}
