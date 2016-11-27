//
//  TableViewController.swift
//  SwifterChat
//
//  Created by Harshita on 04/01/16.
//  Copyright © 2016 HC. All rights reserved.
//

import UIKit
// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l < r
  case (nil, _?):
    return true
  default:
    return false
  }
}


class TableViewController: UITableViewController, ChatFooterDelegate {

    var chatDataSource = TableDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Setup table
        
        //auto layout for dynamic cell sizes
        tableView.estimatedRowHeight = 347
        tableView.rowHeight = UITableViewAutomaticDimension
        
        //table data source
        chatDataSource.parentRef = self
        chatDataSource.refreshDataSource()
        tableView.dataSource = chatDataSource
        tableView.delegate   = chatDataSource
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    
    // MARK: - UITextField delegate
    
    func textFieldShouldReturn(_ textField: UITextField!) -> Bool {
        self.view.endEditing(true)
        return true
    }

    func textFieldDidBeginEditing(_ textField: UITextField!) {
        self.perform(#selector(self.scrollToBottom(animated:)), with: true, afterDelay: CustomDelay.ScrollSelector)
    }
    
    // MARK: - ChatFooterDelegate
    
    func saveThought(message: String) {
        if !message.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).isEmpty {
            chatDataSource.insert(message)
            self.tableView.reloadData()
            self.perform(#selector(self.scrollToBottom(animated:)), with: false, afterDelay: CustomDelay.ScrollSelector)
        }
        else {
            self.view.endEditing(true)
        }
    }
    
    // MARK: -
    
    /**
    For n rows, perform `scrollToRowAtIndexPath(indexPath: NSIndexPath, atScrollPosition scrollPosition: UITableViewScrollPosition, animated: Bool)` till **n-2th** row with the below variable `animated` followed by scrolling till **n-1th** row with animated: `true`
    - parameter animated: animated bool for scrollToRowAtIndexPath for **n-2th** row
    */
    func scrollToBottom(animated : Bool) {
        if (self.chatDataSource.stubData.count) < 2 {
            return
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + CustomDelay.ScrollAnimation) {
            self.tableView.scrollToRow(at: IndexPath(row: (self.chatDataSource.stubData.count) - 2, section: 0), at: .bottom, animated: animated)
            self.tableView.scrollToRow(at: IndexPath(row: (self.chatDataSource.stubData.count) - 1, section: 0), at: .bottom, animated: true)
        }
    }
    

}
