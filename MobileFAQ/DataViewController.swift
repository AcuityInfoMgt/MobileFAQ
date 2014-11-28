//
//  DataViewController.swift
//  MobileFAQ
//
//  Created by Kevin Ferrell on 11/28/14.
//  Copyright (c) 2014 Acuity Inc. All rights reserved.
//

import UIKit

class DataViewController: UIViewController {
    
    @IBOutlet weak var dataLabel: UILabel!
    @IBOutlet weak var containerView: UIView!
    
    var itemController: ModelController?
    var itemIndex: Int = -1
    var dataObject: Dictionary<String, String>?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Display the webview
        var webView = UIWebView(frame: CGRectMake(0, 0, containerView.frame.width, containerView.frame.height))
        webView.autoresizingMask = (UIViewAutoresizing.FlexibleWidth | UIViewAutoresizing.FlexibleHeight);
        
        if let obj: Dictionary<String, String> = dataObject {
            let locationType = obj["LocationType"]
            
            if locationType == "local"
            {
                let filename: String = obj["URL"]!
                let pathExtention = NSString(string: filename).pathExtension
                let pathPrefix = NSString(string: filename).stringByDeletingPathExtension
                
                if let url = NSBundle.mainBundle().URLForResource(pathPrefix, withExtension: pathExtention) {
                    webView.loadRequest(NSURLRequest(URL: url))
                }
                
            } else if locationType == "remote" {
                
                let url = NSURL(string: obj["URL"]!)
                webView.loadRequest(NSURLRequest(URL: url!))
                
            }
            
        }
        
        
        
        containerView.addSubview(webView)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        if let obj: Dictionary<String, String> = dataObject {
            
            let viewableIndex = itemIndex + 1
            
            if let controller = itemController {
                dataLabel!.text = "Item \(viewableIndex) of \(controller.pageData.count)"
            } else {
                dataLabel!.text = "Item \(viewableIndex)"
            }
            
        } else {
            dataLabel!.text = ""
        }
    }
    
    
}
