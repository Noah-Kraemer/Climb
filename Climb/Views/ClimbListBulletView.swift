//
//  ClimbListBulletView.swift
//  Climb
//
//  Created by Noah Kraemer on 12/11/18.
//  Copyright © 2018 Noah Kraemer. All rights reserved.
//

import UIKit

class ClimbListBulletView: UIView {
    
    enum Indentation {
        case area
        case climb
    }
    
    enum Direction {
        case none
        case left
        case center
        case right
    }
    
    enum Location {
        case top
        case bottom
    }
    
    private var circleLayer: CAShapeLayer!
    private var topLineLayer: CAShapeLayer!
    private var bottomLineLayer: CAShapeLayer!
    
    var indentation: Indentation
    var topConnection: Direction
    var bottomConnection: Direction
    
    init(frame: CGRect, indentation: Indentation, topConnection: Direction, bottomConnection: Direction) {
        self.indentation = indentation
        self.topConnection = topConnection
        self.bottomConnection = bottomConnection
        
        super.init(frame: frame)
        
        render()
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.indentation = .area
        self.topConnection = .none
        self.bottomConnection = .none
        
        super.init(coder: aDecoder)
        
        render()
    }
    
    func render() {
        topLineLayer = buildTopLineLayer(indentation: indentation, direction: topConnection)
        bottomLineLayer = buildBottomLineLayer(indentation: indentation, direction: bottomConnection)
        circleLayer = buildCircleLayer(indentation: indentation)
        
        layer.addSublayer(topLineLayer)
        layer.addSublayer(bottomLineLayer)
        layer.addSublayer(circleLayer)
        
        self.backgroundColor = PalleteDarkBlue
    }
    
    func refresh() {
        circleLayer = buildCircleLayer(indentation: indentation)
        topLineLayer = buildTopLineLayer(indentation: indentation, direction: topConnection)
        bottomLineLayer = buildBottomLineLayer(indentation: indentation, direction: bottomConnection)
    }
    
    func buildCircleLayer(indentation: Indentation) -> CAShapeLayer {
        var circleCenter: CGPoint?
        
        switch indentation {
        case .area:
            circleCenter = CGPoint.init(x: 25, y: 50)
        case .climb:
            circleCenter = CGPoint.init(x: 75, y: 25)
        }
        
        let layer = CAShapeLayer()
        
        layer.lineWidth = 5
        layer.path = UIBezierPath(arcCenter: circleCenter!, radius: 10, startAngle: -CGFloat(Double.pi/2), endAngle: CGFloat(3*Double.pi/2), clockwise: true).cgPath
        layer.strokeColor = PalleteYellow.cgColor
        layer.fillColor = PalleteDarkBlue.cgColor
        
        return layer
    }
    
    func buildBottomLineLayer(indentation: Indentation, direction: Direction) -> CAShapeLayer {
        if (indentation == .area) {
            switch direction {
            case .center:
                return drawLine(from: CGPoint(x: 25, y: 50), to: CGPoint(x: 25, y: 125))
            case .right:
                return drawLine(from: CGPoint(x: 25, y: 50), to: CGPoint(x: 75, y: 125))
            default:
                return CAShapeLayer()
            }
        } else {
            switch direction {
            case .center:
                return drawLine(from: CGPoint(x: 75, y: 25), to: CGPoint(x: 75, y: 75))
            case .left:
                return drawLine(from: CGPoint(x: 75, y: 25), to: CGPoint(x: 25, y: 100))
            default:
                return CAShapeLayer()
            }
        }
    }
    
    
    func buildTopLineLayer(indentation: Indentation, direction: Direction) -> CAShapeLayer {
        if (indentation == .area) {
            switch direction {
            case .center:
                return drawLine(from: CGPoint(x: 25, y: 50), to: CGPoint(x: 25, y: -50))
            case .right:
                return drawLine(from: CGPoint(x: 25, y: 50), to: CGPoint(x: 75, y: -25))
            default:
                return CAShapeLayer()
            }
        } else {
            switch direction {
            case .center:
                return drawLine(from: CGPoint(x: 75, y: 25), to: CGPoint(x: 75, y: -25))
            case .left:
                return drawLine(from: CGPoint(x: 75, y: 25), to: CGPoint(x: 25, y: -50))
            default:
                return CAShapeLayer()
            }
        }
    }
    
    func drawLine(from: CGPoint, to: CGPoint) -> CAShapeLayer {
        let layer = CAShapeLayer()
        let path = UIBezierPath()
        
        path.move(to: from)
        path.addLine(to: to)
        
        layer.lineWidth = 5
        layer.path = path.cgPath
        layer.strokeColor = PalleteYellow.cgColor
        layer.fillColor = UIColor.clear.cgColor
        return layer
    }
    
}
