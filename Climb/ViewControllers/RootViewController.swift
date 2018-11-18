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
    var cragListViewController: CragListViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        showSplashViewController()
    }
    
    func showSplashViewController() {
        splashViewController = self.storyboard?.instantiateViewController(withIdentifier: "SplashScreenViewController") as! SplashScreenViewController
        
        splashViewController?.willMove(toParent: self)
        self.addChild(splashViewController!)
        self.view.addSubview(splashViewController!.view)
        splashViewController?.didMove(toParent: self)
    }
    
    func animationCompleted() {
        splashViewController?.willMove(toParent: nil)
        splashViewController?.view.removeFromSuperview()
        splashViewController?.removeFromParent()
        
        showCragListViewController()
    }
    
    func showCragListViewController() {
        cragListViewController = self.storyboard?.instantiateViewController(withIdentifier: "CragListViewController") as! CragListViewController
        
        cragListViewController?.willMove(toParent: self)
        self.addChild(cragListViewController!)
        self.view.addSubview(cragListViewController!.view)
        cragListViewController?.didMove(toParent: self)
    }
}
