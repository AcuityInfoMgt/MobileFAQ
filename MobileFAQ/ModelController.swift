//
//  ModelController.swift
//  MobileFAQ
//
//  Created by Kevin Ferrell on 11/28/14.
//  Copyright (c) 2014 Acuity Inc. All rights reserved.
//

import UIKit


class ModelController: NSObject, UIPageViewControllerDataSource {
    
    var pageData = Array<Dictionary<String, String>>()
    
    override init() {
        super.init()
        
        // Load the FAQ manifest
        let path = NSBundle.mainBundle().pathForResource("FAQs", ofType:"plist")
        let dict = NSDictionary(contentsOfFile:path!)
        var faqList = dict!["FAQs"] as Array<Dictionary<String, String>>
        
        pageData = faqList
    }
    
    func viewControllerAtIndex(index: Int, storyboard: UIStoryboard) -> DataViewController? {
        // Return the data view controller for the given index.
        if (self.pageData.count == 0) || (index >= self.pageData.count) {
            return nil
        }
        
        // Create a new view controller and pass suitable data.
        let dataViewController = storyboard.instantiateViewControllerWithIdentifier("DataViewController") as DataViewController
        dataViewController.itemIndex = index
        dataViewController.dataObject = pageData[index]
        dataViewController.itemController = self
        return dataViewController
    }
    
    func indexOfViewController(viewController: DataViewController) -> Int {
        
        return viewController.itemIndex
        
    }
    
    // MARK: - Page View Controller Data Source
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        var index = self.indexOfViewController(viewController as DataViewController)
        if (index == 0) || (index == NSNotFound) {
            return nil
        }
        
        index--
        return self.viewControllerAtIndex(index, storyboard: viewController.storyboard!)
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        var index = self.indexOfViewController(viewController as DataViewController)
        if index == NSNotFound {
            return nil
        }
        
        index++
        if index == self.pageData.count {
            return nil
        }
        return self.viewControllerAtIndex(index, storyboard: viewController.storyboard!)
    }
    
}

