import UIKit

@IBDesignable
class GradientView: UIView {
    
    @IBInspectable var edgeColor:       UIColor = .black { didSet { updateColors() }}
    @IBInspectable var centerColor:     UIColor = .white { didSet { updateColors() }}
    @IBInspectable var startLocation:   Double =   0.05 { didSet { updateLocations() }}
    @IBInspectable var endLocation:     Double =   0.95 { didSet { updateLocations() }}
    
    override class var layerClass: AnyClass { return CAGradientLayer.self }
    
    var gradientLayer: CAGradientLayer { return layer as! CAGradientLayer }
    
    func updatePoints() {
        gradientLayer.startPoint =  CGPoint(x: 0, y: 0.5)
        gradientLayer.endPoint   =  CGPoint(x: 1, y: 0.5)
    }
    func updateLocations() {
        gradientLayer.locations = [0, startLocation as NSNumber, endLocation as NSNumber, 1]
    }
    func updateColors() {
        gradientLayer.colors    = [edgeColor.cgColor, centerColor.cgColor, centerColor.cgColor, edgeColor.cgColor]
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.cornerRadius = 1
        updatePoints()
        updateLocations()
        updateColors()
    }
}
