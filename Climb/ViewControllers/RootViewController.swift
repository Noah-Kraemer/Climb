//
//  RootViewController.swift
//  Climb
//
//  Created by Noah Kraemer on 3/10/18.
//  Copyright © 2018 Noah Kraemer. All rights reserved.
//

import UIKit

class RootViewController: UIViewController {
    
    var pageViewController: UIPageViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createPageViewController()
    }
    
    func createPageViewController() {
        pageViewController = self.storyboard?.instantiateViewController(withIdentifier: "ClimbPageViewController") as! ClimbPageViewController
        
        self.addChildViewController(pageViewController!)
        self.view.addSubview(pageViewController!.view)
        pageViewController?.didMove(toParentViewController: self)
    }
}
