//
//  TableViewController.swift
//  SwifterChat
//
//  Created by Harshita on 04/01/16.
//  Copyright © 2016 HC. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController, ChatFooterDelegate {

    var tableDataSource: TableDataSource?
    let scrollToBottomSelector = "scrollToBottom:"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Setup table
        
        //Using auto layout for dynamic cell sizes
        tableView.estimatedRowHeight = 347
        tableView.rowHeight = UITableViewAutomaticDimension
        
        //configure table data source
        tableDataSource = TableDataSource()
        tableDataSource!.refreshDataSource()
        tableDataSource?.parentViewRef = self
        tableView.dataSource = tableDataSource
        tableView.delegate = tableDataSource
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    
    // MARK: - UITextField delegate
    
    func textFieldShouldReturn(textField: UITextField!) -> Bool {
        self.view.endEditing(true)
        return true
    }

    func textFieldDidBeginEditing(textField: UITextField!) {
        self.performSelector(Selector(scrollToBottomSelector), withObject: true.hashValue, afterDelay: TVCScrollSelectorDelay)
    }
    
    // MARK: - ChatFooterDelegate
    
    func sendChat(chatMessage: NSString) {
        let messageToBeSent = chatMessage.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet()) as  String!
        if messageToBeSent.isEmpty {
            self.view.endEditing(true)
        }
        else {
            tableDataSource!.insertNewChatMessage(messageToBeSent)
            self.tableView.reloadData()
            self.performSelector(Selector(scrollToBottomSelector), withObject: false, afterDelay: TVCScrollSelectorDelay)
        }
    }
    
    // MARK: -
    
    /**
    For n rows, perform `scrollToRowAtIndexPath(indexPath: NSIndexPath, atScrollPosition scrollPosition: UITableViewScrollPosition, animated: Bool)` till **n-2th** row with the below variable `animated` followed by scrolling till **n-1th** row with animated: `true`
    - parameter animated: animated bool for scrollToRowAtIndexPath for **n-2th** row
    */
    func scrollToBottom(animated : AnyObject) {
        //to
        let delay = TVCScrollAnimationDelay * Double(NSEC_PER_SEC)
        let time = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
        
        dispatch_after(time, dispatch_get_main_queue(), {
            self.tableView.scrollToRowAtIndexPath(NSIndexPath(forRow: (self.tableDataSource?.stubData.count)! - 2, inSection: 0), atScrollPosition: .Bottom, animated: animated.boolValue)
            self.tableView.scrollToRowAtIndexPath(NSIndexPath(forRow: (self.tableDataSource?.stubData.count)! - 1, inSection: 0), atScrollPosition: .Bottom, animated: true)
        })
    }
    

}
