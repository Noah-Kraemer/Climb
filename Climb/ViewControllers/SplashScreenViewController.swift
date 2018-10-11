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
        animatedLogoView = AnimatedLogoView(frame: CGRect(x: 60.0, y: 200.0, width: 125.0, height: 275.0), animationCompleteCallback: self.animationCompleted)
        super.viewDidLoad()
        
        view.addSubview(animatedLogoView!)
        animatedLogoView!.startAnimating()
    }
    
    func animationCompleted() {
        let rootViewController = parent as! RootViewController
        rootViewController.animationCompleted()
    }
}
