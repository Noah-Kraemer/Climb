//
//  ShowCragListViewSegue.swift
//  Climb
//
//  Created by Noah Kraemer on 22/11/18.
//  Copyright © 2018 Noah Kraemer. All rights reserved.
//

import UIKit

class ShowCragListViewSegue: UIStoryboardSegue {
    override func perform() {
        let listViewController = self.destination as! CragListViewController
        
        let screenWidth = UIScreen.main.bounds.size.width
        let screenHeight = UIScreen.main.bounds.size.height
        
        // Access the app's key window and insert the destination view behind the current (source) one.
        let window = UIApplication.shared.keyWindow
        window?.insertSubview(listViewController.view, aboveSubview: self.source.view)
        listViewController.view.frame = CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight)
        
        // Animate the transition.
        UIView.animate(withDuration: 0.6, animations: { () -> Void in
            
        }) { (Finished) -> Void in
            self.source.present(self.destination as UIViewController, animated: false, completion: {
            })
        }
    }
}
