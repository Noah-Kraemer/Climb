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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showSplashViewController()
    }
    
    func showSplashViewController() {
        splashViewController = self.storyboard?.instantiateViewController(withIdentifier: "SplashScreenViewController") as? SplashScreenViewController
        
        splashViewController?.willMove(toParent: self)
        self.addChild(splashViewController!)
        self.view.addSubview(splashViewController!.view)
        splashViewController?.didMove(toParent: self)
    }
    
    func animationCompleted() {
        splashViewController?.willMove(toParent: nil)
        splashViewController?.view.removeFromSuperview()
        splashViewController?.removeFromParent()
        
        performSegue(withIdentifier: "showCragListViewSegue", sender: self)
    }
}
