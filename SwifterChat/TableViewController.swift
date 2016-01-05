//
//  TableViewController.swift
//  SwifterChat
//
//  Created by Harshita on 04/01/16.
//  Copyright © 2016 HC. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController, ChatFooterDelegate {

    let chatData = ChatDataManager()
    var stubData : [ChatDataManager.ChatEntry] = []
    var cellHeight: [CGFloat] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.estimatedRowHeight = 347
        tableView.rowHeight = UITableViewAutomaticDimension
        refreshDataSource()
        tableView.reloadData()
    }
    
    func refreshDataSource() {
        stubData = chatData.chatMessages
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stubData.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ChatBubbleCell", forIndexPath: indexPath) as! ChatBubbleCell
        let chat = stubData[indexPath.row]
        cell.chatLabel.text = chat.chatMessage as String
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateStyle = .ShortStyle
        dateFormatter.timeStyle = .ShortStyle
        cell.timeStampLabel.text = dateFormatter.stringFromDate(chat.timeStamp) as String
        return cell
    }
    
    override func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let cell = self.tableView.dequeueReusableCellWithIdentifier("ChatFooterView") as! ChatFooterView
        cell.frame = CGRectMake(0, 0, CGRectGetWidth(tableView.frame), 71)
        cell.delegate = self;
        let footerView = UIView(frame: cell.frame)
        footerView.addSubview(cell)
        return footerView
    }
    
    override func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 71
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if cellHeight.count > indexPath.row {
            return cellHeight[indexPath.row]
        }

        let sizingCell = self.tableView.dequeueReusableCellWithIdentifier("ChatBubbleCell") as! ChatBubbleCell
        let chat = stubData[indexPath.row]
        sizingCell.chatLabel.text = chat.chatMessage as String
        sizingCell.setNeedsLayout()
        sizingCell.layoutIfNeeded()
        let height = sizingCell.contentView.systemLayoutSizeFittingSize(UILayoutFittingCompressedSize).height;
        cellHeight.append(height)
        return height;
    }
    
    func textFieldShouldReturn(textField: UITextField!) -> Bool {
        self.view.endEditing(true)
        return true
    }

    func textFieldDidBeginEditing(textField: UITextField!) {
        self.performSelector(Selector("scrollToBottom"), withObject: nil, afterDelay: 0.3)
    }
    
    func scrollToBottom() {
        let lastIndexPath = NSIndexPath(forRow: stubData.count - 1, inSection: 0)
        self.tableView.scrollToRowAtIndexPath(lastIndexPath, atScrollPosition: UITableViewScrollPosition.None, animated: true)
    }
    
    func sendChat(chatMessage: NSString) {
        let messageToBeSent = chatMessage.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet()) as  NSString!
        if messageToBeSent.length != 0 {
            print("Sending message: \(messageToBeSent)")
            chatData.addNewChat(messageToBeSent, outgoingMessage: true)
            refreshDataSource()
            self.tableView.reloadData()
        }
        else {
            self.view.endEditing(true)
        }
        
        self.performSelector(Selector("scrollToBottom"), withObject: nil, afterDelay: 0.3)
    }
}
