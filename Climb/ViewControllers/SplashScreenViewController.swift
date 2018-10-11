//
//  SplashScreenViewController.swift
//  Climb
//
//  Created by Noah Kraemer on 7/10/18.
//  Copyright © 2018 Noah Kraemer. All rights reserved.
//

import UIKit

class SplashScreenViewController: UIViewController {
    
    @IBOutlet weak var leftLabel: UILabel!
    @IBOutlet weak var rightLabel: UILabel!
    
    var animatedLogoView: AnimatedLogoView?
    
    override func viewDidLoad() {
        createAnimatedLogoView()

        animatedLogoView!.startAnimating()
        
        super.viewDidLoad()
    }
    
    func createAnimatedLogoView() {
        animatedLogoView = AnimatedLogoView(frame: CGRect(x: 0, y: 0, width: 125.0, height: 275.0), animationCompleteCallback: self.animationCompleted)
        view.addSubview(animatedLogoView!)
        
        animatedLogoView!.translatesAutoresizingMaskIntoConstraints = false
        let horizontalConstraint = NSLayoutConstraint(item: animatedLogoView!, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: -65)
        let verticalConstraint = NSLayoutConstraint(item: animatedLogoView!, attribute: .centerY, relatedBy: .equal, toItem: view, attribute: .centerY, multiplier: 1, constant: 0)
        let widthConstraint = NSLayoutConstraint(item: animatedLogoView!, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 125)
        let heightConstraint = NSLayoutConstraint(item: animatedLogoView!, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 275)
        view.addConstraints([horizontalConstraint, verticalConstraint, widthConstraint, heightConstraint])
    }
    
    func animationCompleted() {
        let rootViewController = parent as! RootViewController
        rootViewController.animationCompleted()
    }
}
