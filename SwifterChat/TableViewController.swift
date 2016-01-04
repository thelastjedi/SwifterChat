//
//  TableViewController.swift
//  SwifterChat
//
//  Created by Harshita on 04/01/16.
//  Copyright © 2016 HC. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController, ChatFooterDelegate {

    @IBOutlet var chatTableView: UITableView!
    var stubData = []
    override func viewDidLoad() {
        super.viewDidLoad()
        
        stubData = ["A long time ago in a galaxy far, far away.",
            "It is a period of civil war. Rebel spaceships, striking from a hidden base, have won their first victory against the evil Galactic Empire.",
            "During the battle, Rebel spies managed to steal secret plans to the Empire's ultimate weapon, the DEATH STAR, an armored space station with enough power to destroy an entire planet.",
            "Pursued by the Empire's sinister agents, Princess Leia races home aboard her starship, custodian of the stolen plans that can save her people and restore freedom to the galaxy"]
        
        tableView.estimatedRowHeight = 347
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.reloadData()
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

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> ChatBubbleCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ChatBubbleCell", forIndexPath: indexPath) as! ChatBubbleCell
        cell.chatMessage.text = stubData[indexPath.row] as? String
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

    func textFieldShouldReturn(textField: UITextField!) -> Bool {
        self.view.endEditing(true)
        return true
    }

    func textFieldDidBeginEditing(textField: UITextField!) {
        self.performSelector(Selector("scrollToBottom"), withObject: nil, afterDelay: 0.3)
    }
    
    func scrollToBottom() {
        let lastIndexPath = NSIndexPath(forRow: stubData.count - 1, inSection: 0)
        chatTableView.scrollToRowAtIndexPath(lastIndexPath, atScrollPosition: UITableViewScrollPosition.None, animated: true)
    }
    
    func sendChat(chatMessage: NSString) {
        self.view.endEditing(true)
        self.performSelector(Selector("scrollToBottom"), withObject: nil, afterDelay: 0.3)
        let messageToBeSent = chatMessage.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet()) as  NSString!
        if messageToBeSent.length != 0 {
            print(messageToBeSent)
        }
    }
}
