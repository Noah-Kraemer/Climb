//
//  RootViewController.swift
//  Climb
//
//  Created by Noah Kraemer on 3/10/18.
//  Copyright © 2018 Noah Kraemer. All rights reserved.
//

import UIKit

class RootViewController: UIViewController {
    
    var splashViewController: SplashScreenViewController?
    var pageViewController: UIPageViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        showSplashViewController()
    }
    
    func showSplashViewController() {
        splashViewController = SplashScreenViewController()
        
        splashViewController?.willMove(toParent: self)
        self.addChild(splashViewController!)
        self.view.addSubview(splashViewController!.view)
        splashViewController?.didMove(toParent: self)
    }
    
    func animationCompleted() {
        splashViewController?.willMove(toParent: nil)
        splashViewController?.view.removeFromSuperview()
        splashViewController?.removeFromParent()
        
        showPageViewController()
    }
    
    func showPageViewController() {
        pageViewController = self.storyboard?.instantiateViewController(withIdentifier: "ClimbPageViewController") as! ClimbPageViewController
        
        pageViewController?.willMove(toParent: self)
        self.addChild(pageViewController!)
        self.view.addSubview(pageViewController!.view)
        pageViewController?.didMove(toParent: self)
    }
}
