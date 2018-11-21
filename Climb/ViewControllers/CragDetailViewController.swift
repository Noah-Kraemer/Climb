//
//  CragDetailViewController.swift
//  Climb
//
//  Created by Noah Kraemer on 16/11/18.
//  Copyright © 2018 Noah Kraemer. All rights reserved.
//

import UIKit

class CragDetailViewController: UIViewController {
    
    //Panels
    @IBOutlet weak var topPanel: UIView!
    @IBOutlet weak var bottomPanel: UIView!
    @IBOutlet weak var gutterPanel: UIView!
    
    //Images
    @IBOutlet weak var cragImageView: UIImageView!
    @IBOutlet weak var driveTimeImageView: UIImageView!
    @IBOutlet weak var hikeTimeImageView: UIImageView!
    @IBOutlet weak var climbCountImageView: UIImageView!
    @IBOutlet weak var weatherImageView: UIImageView!
    
    //Labels
    @IBOutlet weak var cragTitleLabel: UILabel!
    @IBOutlet weak var driveTimeLabel: UILabel!
    @IBOutlet weak var hikeTimeLabel: UILabel!
    @IBOutlet weak var climbCountLabel: UILabel!
    @IBOutlet weak var accessLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    //TextViews
    @IBOutlet weak var accessTextView: UITextView!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    @IBOutlet weak var topGradientView: GradientView!
    @IBOutlet weak var bottomGradientView: GradientView!
    @IBOutlet weak var backButton: UIButton!
    
    var crag: CragModel?
    var indexPath: IndexPath?
    var accessExpanded: Bool = true
    var showClimbListTransition: ShowClimbListTransition?
    
    override func viewDidLoad() {
        cragImageView.image = UIImage(named: crag!.imageName)
        driveTimeImageView.image = UIImage(named: "driveIcon.png")
        hikeTimeImageView.image = UIImage(named: "hikeIcon.png")
        climbCountImageView.image = UIImage(named: "climbCountIcon.png")
        weatherImageView.image = UIImage(named: crag!.weather + "Icon.png") //TODO make dynamic
        
        cragTitleLabel.text = crag!.name
        cragTitleLabel.sizeToFit()
        
        driveTimeLabel.text = crag!.driveTime
        hikeTimeLabel.text = crag!.hikeTime
        //climbCountLabel.text =
        
        accessLabel.text = "Access"
        descriptionLabel.text = "Description"
        
        accessTextView.text = crag?.accessText
        descriptionTextView.text = crag?.descriptionText
        
        bottomGradientView.fadeDirection = .vertical
        
        showClimbListTransition = ShowClimbListTransition(viewController: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "showClimbListSegue") {
            segue.destination.transitioningDelegate = self
        }
        
        if (segue.identifier == "collapseCragDetailSegue") {
            if let customSegue = segue as? CollapseCragDetailSegue {
                customSegue.cellIndexPath = indexPath
            }
        }
    }
}

extension CragDetailViewController: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController,
                             presenting: UIViewController,
                             source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return ShowClimbListAnimationController(interactionController: self.showClimbListTransition!)
    }
    
    func interactionControllerForPresentation(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        guard let animator = animator as? ShowClimbListAnimationController,
            let interactionController = animator.interactionController,
            interactionController.interactionInProgress
            else {
                return nil
        }
        return interactionController
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        guard let climbListViewController = dismissed as? ClimbListViewController else {
            return nil
        }
        return DismissClimbListAnimationController(interactionController: climbListViewController.dismissClimbListTransition!)
    }
    
    func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        guard let animator = animator as? DismissClimbListAnimationController,
            let interactionController = animator.interactionController,
            interactionController.interactionInProgress
            else {
                return nil
        }
        return interactionController
    }
}
