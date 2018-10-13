//
//  CragPageContentController.swift
//  Climb
//
//  Created by Noah Kraemer on 7/10/18.
//  Copyright © 2018 Noah Kraemer. All rights reserved.
//

import UIKit

class CragPageContentController: UIViewController, UIScrollViewDelegate {
    
    @IBOutlet weak var cragImageView: UIImageView!
    @IBOutlet weak var cragImageScrollView: UIScrollView!
    @IBOutlet weak var nameLabel: UILabel!
    
    var pageViewIndex: Int?
    var cragImageName: String?
    var cragName: String?
    
    var isInitialView: Bool = false
    var initialPanOffset: Int?
    var reversePanDirection: Bool?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cragImageView.image = scaleToHeight(image: UIImage.init(named: cragImageName!)!, height: cragImageScrollView.bounds.height);
        
        cragImageScrollView.bounds.origin.x += CGFloat(integerLiteral: initialPanOffset!)

        nameLabel.text = cragName!
        
        if (isInitialView) {
            animatePan()
        }
    }
    
    func animatePan() {
        let startBounds = cragImageScrollView.bounds
        
        var endBounds = cragImageScrollView.bounds
        if (reversePanDirection!) {
            endBounds.origin.x -= 200
        }  else {
            endBounds.origin.x += 200
        }
        
        let animation: CABasicAnimation = CABasicAnimation(keyPath: "bounds")
        animation.duration = 20.0
        animation.timingFunction = CAMediaTimingFunction.init(name: .linear)
        animation.fromValue = NSValue.init(cgRect: startBounds)
        animation.toValue = NSValue.init(cgRect: endBounds)
        
        let reverseAnimation: CABasicAnimation = CABasicAnimation(keyPath: "bounds")
        reverseAnimation.duration = 20.0
        reverseAnimation.beginTime = 20.0
        reverseAnimation.timingFunction = CAMediaTimingFunction.init(name: .linear)
        reverseAnimation.fromValue = NSValue.init(cgRect: endBounds)
        reverseAnimation.toValue = NSValue.init(cgRect: startBounds)
        
        let groupAnimation = CAAnimationGroup()
        groupAnimation.animations = [animation, reverseAnimation]
        groupAnimation.repeatCount = Float.infinity
        groupAnimation.duration = 40.0
        
        cragImageScrollView.layer.add(groupAnimation, forKey: nil)
    }
    
    func clearAnimations() {
        cragImageScrollView.layer.removeAllAnimations()
    }
    
    func scaleToHeight(image: UIImage, height: CGFloat) -> UIImage {
        let size = image.size
        
        let heightRatio = height / size.height
        
        let newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        
        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
        
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
    
    @IBAction func handleSwipeUp(_ sender: UISwipeGestureRecognizer) {
        print("swiped up from", cragName!)
    }
}
