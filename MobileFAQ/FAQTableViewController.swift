//
//  FAQTableViewController.swift
//  MobileFAQ
//
//  Created by Kevin Ferrell on 11/28/14.
//  Copyright (c) 2014 Acuity Inc. All rights reserved.
//

import UIKit

class FAQTableViewController: UITableViewController {

    var dataViewController: DataViewController!
    var faqData = Array<Dictionary<String, String>>()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Load the FAQ manifest
        let path = NSBundle.mainBundle().pathForResource("FAQs", ofType:"plist")
        let dict = NSDictionary(contentsOfFile:path!)
        var faqList = dict!["FAQs"] as Array<Dictionary<String, String>>
        faqData = faqList
        
        let cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItemStyle.Bordered, target: self, action: Selector("cancelEvent"))
        self.navigationItem.rightBarButtonItem = cancelButton
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return faqData.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("faqCell") as? UITableViewCell
        
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "faqCell")
        }
        
        let faq = faqData[indexPath.row]
        
        cell!.textLabel.text = faq["Title"]
        
        return cell!
    }
    
    // MARK: - Close Navigation Window
    
    func cancelEvent() {
        dataViewController.dismissViewControllerAnimated(true, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
