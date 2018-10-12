//
//  AnimatedLogoView.swift
//  Climb
//
//  Created by Noah Kraemer on 7/10/18.
//  Copyright © 2018 Noah Kraemer. All rights reserved.
//

import UIKit

class AnimatedLogoView: UIView {
    
    private let ANIMATION_DURATION: TimeInterval = 0.2
    
    private let easeInTimingFunction = CAMediaTimingFunction(controlPoints: 0.895, 0.03, 0.685, 0.22)
    private let easeOutTimingFunction = CAMediaTimingFunction(controlPoints: 0.165, 0.84, 0.44, 1)
    private let easeInOutTimingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
    
    private var blCircleLayer: CAShapeLayer!
    private var bcCircleLayer: CAShapeLayer!
    private var tcCircleLayer: CAShapeLayer!
    private var trCircleLayer: CAShapeLayer!
    
    private var blCircleCenter: CGPoint = CGPoint.init(x: 12.5, y: 262.5)
    private var bcCircleCenter: CGPoint = CGPoint.init(x: 62.5, y: 212.5)
    private var tcCircleCenter: CGPoint = CGPoint.init(x: 62.5, y: 62.5)
    private var trCircleCenter: CGPoint = CGPoint.init(x: 112.5, y: 12.5)
    
    private var bottomLineLayer: CAShapeLayer!
    private var centerLineLayer: CAShapeLayer!
    private var topLineLayer: CAShapeLayer!
    
    private var beginTime: TimeInterval = 0
    
    private var animationCompleteCallback: (() -> Void)?

    init(frame: CGRect, animationCompleteCallback: @escaping () -> Void) {
        self.animationCompleteCallback = animationCompleteCallback
        
        super.init(frame: frame)
        
        blCircleLayer = generateCircleLayer(center: blCircleCenter)
        bcCircleLayer = generateCircleLayer(center: bcCircleCenter)
        tcCircleLayer = generateCircleLayer(center: tcCircleCenter)
        trCircleLayer = generateCircleLayer(center: trCircleCenter)
        
        bottomLineLayer = generateLineLayer(from: CGPoint.init(x: 19.5, y: 255.5), to: CGPoint.init(x: 55.5, y: 219.5))
        centerLineLayer = generateLineLayer(from: CGPoint.init(x: 62.5, y: 202.5), to: CGPoint.init(x: 62.5, y: 72.5))
        topLineLayer = generateLineLayer(from: CGPoint.init(x: 69.5, y: 55.5), to: CGPoint.init(x: 105.5, y: 19.5))
        
        layer.addSublayer(blCircleLayer)
        layer.addSublayer(bcCircleLayer)
        layer.addSublayer(tcCircleLayer)
        layer.addSublayer(trCircleLayer)
        
        layer.addSublayer(bottomLineLayer)
        layer.addSublayer(centerLineLayer)
        layer.addSublayer(topLineLayer)
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.animationCompleteCallback = nil
        super.init(coder: aDecoder)
    }
    
    func startAnimating() {
        var animationChain: [(CAShapeLayer, CAAnimationGroup)] = []
        
        animationChain.append((blCircleLayer, createCircleLayerAnimation(layer: blCircleLayer, centerPoint: blCircleCenter)))
        animationChain.append((bottomLineLayer, createLineLayerAnimation(layer: bottomLineLayer)))
        animationChain.append((bcCircleLayer, createCircleLayerAnimation(layer: bcCircleLayer, centerPoint: bcCircleCenter)))
        animationChain.append((centerLineLayer, createLineLayerAnimation(layer: centerLineLayer)))
        animationChain.append((tcCircleLayer, createCircleLayerAnimation(layer: tcCircleLayer, centerPoint: tcCircleCenter)))
        animationChain.append((topLineLayer, createLineLayerAnimation(layer: topLineLayer)))
        animationChain.append((trCircleLayer, createCircleLayerAnimation(layer: trCircleLayer, centerPoint: trCircleCenter)))
        
        performChainedAnimations(animations: animationChain, onComplete: animationCompleteCallback!)
    }
    
    func performChainedAnimations(animations: [(CAShapeLayer, CAAnimationGroup)], onComplete: @escaping () -> Void, index: Int = 0) {
        if (index == animations.count) {
            onComplete()
        } else {
            let (layer, animation) = animations[index]
            CATransaction.begin()
            CATransaction.setCompletionBlock{ [weak self] in
                self?.performChainedAnimations(animations: animations, onComplete: onComplete, index: index + 1)
            }
            layer.isHidden = false
            layer.add(animation, forKey: nil)
            CATransaction.commit()
        }
    }

    func generateCircleLayer(center: CGPoint) -> CAShapeLayer {
        let layer = CAShapeLayer()
        layer.lineWidth = 5
        layer.path = UIBezierPath(arcCenter: center, radius: 10, startAngle: -CGFloat(Double.pi/2), endAngle: CGFloat(3*Double.pi/2), clockwise: true).cgPath
        layer.strokeColor = PalleteYellow.cgColor
        layer.fillColor = UIColor.clear.cgColor
        layer.isHidden = true
        return layer
    }
    
    func generateLineLayer(from: CGPoint, to: CGPoint) -> CAShapeLayer {
        let layer = CAShapeLayer()
        let path = UIBezierPath()
        
        path.move(to: from)
        path.addLine(to: to)
        
        layer.lineWidth = 5
        layer.path = path.cgPath
        layer.strokeColor = PalleteYellow.cgColor
        layer.fillColor = UIColor.clear.cgColor
        layer.isHidden = true
        return layer
    }
    
    func createCircleLayerAnimation(layer: CAShapeLayer, centerPoint: CGPoint) -> CAAnimationGroup {
        // growTransform
        let growTranslateStart = CATransform3DMakeTranslation(centerPoint.x - centerPoint.x * 0.25, centerPoint.y - centerPoint.y * 0.25, 1)
        let growTranslateEnd = CATransform3DMakeTranslation(centerPoint.x - centerPoint.x * 1.5, centerPoint.y - centerPoint.y * 1.5, 1)
        let growTransformAnimation = CABasicAnimation(keyPath: "transform")
        growTransformAnimation.timingFunction = easeInTimingFunction
        growTransformAnimation.duration = ANIMATION_DURATION
        growTransformAnimation.fromValue = NSValue(caTransform3D: CATransform3DScale(growTranslateStart, 0.25, 0.25, 1))
        growTransformAnimation.toValue = NSValue(caTransform3D: CATransform3DScale(growTranslateEnd, 1.5, 1.5, 1))
        
        // shrinkTransform
        let shrinkTransformAnimation = CABasicAnimation(keyPath: "transform")
        shrinkTransformAnimation.timingFunction = easeOutTimingFunction
        shrinkTransformAnimation.duration = ANIMATION_DURATION
        shrinkTransformAnimation.beginTime = ANIMATION_DURATION
        shrinkTransformAnimation.fromValue = NSValue(caTransform3D: CATransform3DScale(growTranslateEnd, 1.5, 1.5, 1))
        shrinkTransformAnimation.toValue = NSValue(caTransform3D: CATransform3DIdentity)

        // Group
        let groupAnimation = CAAnimationGroup()
        groupAnimation.animations = [growTransformAnimation, shrinkTransformAnimation]
        groupAnimation.repeatCount = 1
        groupAnimation.duration = 2 * ANIMATION_DURATION
        
        return groupAnimation
    }
    
    func createLineLayerAnimation(layer: CAShapeLayer) -> CAAnimationGroup {
        let strokeEndAnimation = CAKeyframeAnimation(keyPath: "strokeEnd")
        strokeEndAnimation.timingFunction = easeInOutTimingFunction
        strokeEndAnimation.duration = ANIMATION_DURATION
        strokeEndAnimation.values = [0.0, 1.0]
        strokeEndAnimation.keyTimes = [0.0, 1.0]
        
        // Group
        let groupAnimation = CAAnimationGroup()
        groupAnimation.animations = [strokeEndAnimation]
        groupAnimation.repeatCount = 1
        groupAnimation.duration = ANIMATION_DURATION
        
        return groupAnimation
    }
}
