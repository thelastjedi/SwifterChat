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
    
    func textFieldShouldReturn(_ textField: UITextField!) -> Bool {
        self.view.endEditing(true)
        return true
    }

    func textFieldDidBeginEditing(_ textField: UITextField!) {
        self.perform(Selector(scrollToBottomSelector), with: true.hashValue, afterDelay: TVCScrollSelectorDelay)
    }
    
    // MARK: - ChatFooterDelegate
    
    func sendChat(message: String) {
        if !message.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).isEmpty {
            tableDataSource!.insertNewThought(message)
            self.tableView.reloadData()
            self.perform(Selector(scrollToBottomSelector), with: false, afterDelay: TVCScrollSelectorDelay)
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
    func scrollToBottom(_ animated : AnyObject) {
        if (self.tableDataSource?.stubData.count) < 2 {
            return
        }
        //to
        let delay = TVCScrollAnimationDelay * Double(NSEC_PER_SEC)
        let time = DispatchTime.now() + Double(Int64(delay)) / Double(NSEC_PER_SEC)
        
        DispatchQueue.main.asyncAfter(deadline: time, execute: {
            self.tableView.scrollToRow(at: IndexPath(row: (self.tableDataSource?.stubData.count)! - 2, section: 0), at: .bottom, animated: animated.boolValue)
            self.tableView.scrollToRow(at: IndexPath(row: (self.tableDataSource?.stubData.count)! - 1, section: 0), at: .bottom, animated: true)
        })
    }
    

}
