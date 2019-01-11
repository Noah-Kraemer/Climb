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
    @IBOutlet weak var accessCaratImageView: UIImageView!
    @IBOutlet weak var descriptionCaratImageView: UIImageView!
    
    //Labels
    @IBOutlet weak var cragTitleLabel: UILabel!
    @IBOutlet weak var driveTimeLabel: UILabel!
    @IBOutlet weak var hikeTimeLabel: UILabel!
    @IBOutlet weak var climbCountLabel: UILabel!
    
    //TextViews
    @IBOutlet weak var accessTextView: UITextView!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    //Buttons
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var accessButton: UIButton!
    @IBOutlet weak var descriptionButton: UIButton!
    
    //Constraints
    @IBOutlet weak var showAccessHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var hideAccessHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var showDescriptionHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var hideDescriptionHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var topGradientView: GradientView!
    @IBOutlet weak var bottomGradientView: GradientView!
    
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
        
        accessTextView.text = crag?.accessText
        descriptionTextView.text = crag?.descriptionText
        
        accessCaratImageView.transform = CGAffineTransform(rotationAngle: 0)
        descriptionCaratImageView.transform = CGAffineTransform(rotationAngle: .pi)
        
        bottomGradientView.fadeDirection = .vertical
        
        showClimbListTransition = ShowClimbListTransition(viewController: self)
    }
    
    @IBAction func toggleAccessExpanded(_ sender: UIButton) {
        accessExpanded = !accessExpanded
        
        let accessFrame = accessTextView.frame
        let descriptionFrame = descriptionTextView.frame
        
        let expandedHeight = accessFrame.height > descriptionFrame.height ? accessFrame.height : descriptionFrame.height
        
        NSLayoutConstraint.deactivate([self.hideAccessHeightConstraint, self.showDescriptionHeightConstraint, self.showAccessHeightConstraint, self.hideDescriptionHeightConstraint])
        
        UIView.animate(withDuration: 0.6, animations: {
            if (self.accessExpanded) {
                self.accessCaratImageView.transform = CGAffineTransform(rotationAngle: 0)
                self.descriptionCaratImageView.transform = CGAffineTransform(rotationAngle: .pi)
                
                self.accessTextView.frame = CGRect(x: accessFrame.minX, y: accessFrame.minY, width: accessFrame.width, height: expandedHeight)
                self.descriptionTextView.frame = CGRect(x: descriptionFrame.minX, y: descriptionFrame.minY, width: descriptionFrame.width, height: 0)
                
            } else {
                self.accessCaratImageView.transform = CGAffineTransform(rotationAngle: .pi)
                self.descriptionCaratImageView.transform = CGAffineTransform(rotationAngle: 0)
                
                self.accessTextView.frame = CGRect(x: accessFrame.minX, y: accessFrame.minY, width: accessFrame.width, height: 0)
                self.descriptionTextView.frame = CGRect(x: descriptionFrame.minX, y: descriptionFrame.minY, width: descriptionFrame.width, height: expandedHeight)
            }
            
            self.view.layoutIfNeeded()
        }, completion: { _ in
            if (self.accessExpanded) {
                //NSLayoutConstraint.deactivate([self.hideAccessHeightConstraint, self.showDescriptionHeightConstraint])
                NSLayoutConstraint.activate([self.showAccessHeightConstraint, self.hideDescriptionHeightConstraint])
            } else {
                //NSLayoutConstraint.deactivate([self.showAccessHeightConstraint, self.hideDescriptionHeightConstraint])
                NSLayoutConstraint.activate([self.hideAccessHeightConstraint, self.showDescriptionHeightConstraint])
            }
        })
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
