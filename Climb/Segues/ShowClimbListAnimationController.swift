//
//  ShowClimbListAnimationController.swift
//  Climb
//
//  Created by Noah Kraemer on 19/11/18.
//  Copyright © 2018 Noah Kraemer. All rights reserved.
//

import UIKit

class ShowClimbListAnimationController: NSObject, UIViewControllerAnimatedTransitioning {
    
    let interactionController: ShowClimbListTransition?
    
    init(interactionController: ShowClimbListTransition) {
        self.interactionController = interactionController
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.6
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        let source = transitionContext.viewController(forKey: .from)
        let destination = transitionContext.viewController(forKey: .to)
        
        let screenWidth = UIScreen.main.bounds.size.width
        let screenHeight = UIScreen.main.bounds.size.height
        
        destination!.view.frame = CGRect(x: screenWidth, y: 0, width: screenWidth, height: screenHeight)
        
        containerView.addSubview(destination!.view)
        
        let duration = transitionDuration(using: transitionContext)
        
        UIView.animate(withDuration: duration,
                       delay: 0,
                       options: .curveLinear,
                       animations: {
            source!.view.frame = CGRect(x: -screenWidth, y: 0, width: screenWidth, height: screenHeight)
            destination!.view.frame = CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight)
        }, completion: { _ in
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        })
    }
}
