import UIKit

@IBDesignable
class GradientView: UIView {
    
    enum Direction {
        case vertical
        case horizontal
    }
    
    @IBInspectable var startColor: UIColor = .black { didSet { updateColors() }}
    @IBInspectable var endColor: UIColor = .white { didSet { updateColors() }}
    @IBInspectable var fadeStartLocation: Double = 0 { didSet { updateLocations() }}
    @IBInspectable var fadeEndLocation: Double = 1 { didSet { updateLocations() }}
    
    var fadeDirection: Direction = .vertical { didSet { updatePoints() }}
    
    override class var layerClass: AnyClass { return CAGradientLayer.self }
    
    var gradientLayer: CAGradientLayer { return layer as! CAGradientLayer }
    
    func updatePoints() {
        switch (fadeDirection) {
        case .vertical:
            gradientLayer.startPoint = CGPoint(x: 0.5, y: 0)
            gradientLayer.endPoint   = CGPoint(x: 0.5, y: 1)
        case .horizontal:
            gradientLayer.startPoint = CGPoint(x: 0, y: 0.5)
            gradientLayer.endPoint   = CGPoint(x: 1, y: 0.5)
        }
    }
    
    func updateLocations() {
        gradientLayer.locations = [0, fadeStartLocation as NSNumber, fadeEndLocation as NSNumber, 1]
    }
    
    func updateColors() {
        gradientLayer.colors = [startColor.cgColor, startColor.cgColor, endColor.cgColor, endColor.cgColor]
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.cornerRadius = 1
        updatePoints()
        updateLocations()
        updateColors()
    }
}
