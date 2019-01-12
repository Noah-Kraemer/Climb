//
//  DismissClimbListTransition.swift
//  Climb
//
//  Created by Noah Kraemer on 19/11/18.
//  Copyright © 2018 Noah Kraemer. All rights reserved.
//

import UIKit

class DismissClimbListTransition: UIPercentDrivenInteractiveTransition {

    var interactionInProgress = false
    
    private var shouldCompleteTransition = false
    private weak var viewController: UIViewController!
    
    init(viewController: UIViewController) {
        super.init()
        self.viewController = viewController
        prepareGestureRecognizer(in: viewController.view)
    }
    
    private func prepareGestureRecognizer(in view: UIView) {
        let gesture = DirectionalPanGestureRecognizer(direction: .horizontal, target: self, action: #selector(handleGesture(_:)))
        view.addGestureRecognizer(gesture)
    }
    
    @objc func handleGesture(_ gestureRecognizer: UIPanGestureRecognizer) {
        let translation = gestureRecognizer.translation(in: gestureRecognizer.view!.superview!)
        let velocity = gestureRecognizer.velocity(in: gestureRecognizer.view!.superview!)
        
        var progress = (translation.x / UIScreen.main.bounds.size.width)
        progress = CGFloat(fminf(fmaxf(Float(progress), 0.0), 1.0))
        
        switch gestureRecognizer.state {
        case .began:
            interactionInProgress = true
            viewController.dismiss(animated: true, completion: nil)
        case .changed:
            shouldCompleteTransition = progress > 0.5 || velocity.x > 0
            update(progress)
        case .cancelled:
            interactionInProgress = false
            cancel()
        case .ended:
            interactionInProgress = false
            if shouldCompleteTransition {
                finish()
            } else {
                cancel()
            }
        default:
            break
        }
    }
}
