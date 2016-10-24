//
//  PageViewController.swift
//  GestureGameApp
//
//  Created by Danya on 23.10.16.
//  Copyright © 2016 Danya. All rights reserved.
//

import UIKit

class PageViewController: UIViewController, UIPageViewControllerDataSource {

    var pageControl : UIPageViewController!
    
    var images : [String] = ["tutorial2","tutorial1"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.pageControl = self.storyboard?.instantiateViewController(withIdentifier: "page") as? UIPageViewController
        self.pageControl.dataSource = self
        let startVC = self.viewAtIndex(index: 0) as? ContentViewController
        
        let viewControllers = NSArray(object: startVC)
        
        self.pageControl.setViewControllers(viewControllers as? [UIViewController], direction: .forward, animated: true, completion: nil)
        pageControl.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        self.addChildViewController(pageControl)
        self.view.addSubview(pageControl.view)
        self.pageControl.didMove(toParentViewController: self)
    }
    
    func viewAtIndex(index : Int) -> UIViewController? {
        if (index >= images.count || self.images.count == 0) {
            return ContentViewController()
        }
        
        let VC : ContentViewController = (self.storyboard?.instantiateViewController(withIdentifier: "tutorial") as? ContentViewController)!
        VC.ind = index;
        VC.photoName = images[index]
        //VC.image.image = UIImage(named: images[ind])
        return VC
    }
    
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        let VC = viewController as! ContentViewController
        var ind = VC.ind as Int
        
        if (ind == images.count - 1 || ind == NSNotFound) {
            return nil
        }
        else {
            ind += 1
            return self.viewAtIndex(index: ind)
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        let VC = viewController as! ContentViewController
        var ind = VC.ind as Int

        if (ind == 0 || ind == NSNotFound) {
            return nil
        }
        else {
            ind -= 1
            return self.viewAtIndex(index: ind)
        }
    }

    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return 2
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return 0
    }
}
