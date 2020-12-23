//
//  UIView+Ext.swift
//  SBase


import UIKit

class GradientLayer: CAGradientLayer { }

public extension UIView {
    
    /// return gesture of view
    /// - Parameter comparison: compare ges
    func getGesture<G: UIGestureRecognizer>(_ comparison: ((G) -> Bool)? = nil) -> G? {
        return gestureRecognizers?.filter { g in
            if let comparison = comparison {
                return g is G && comparison(g as! G)
            }
            
            return g is G
        }.first as? G
    }
    
    /// get attr constraint
    /// - Parameter attr: attr constrait
    func getConstraint(byAttribute attr: NSLayoutConstraint.Attribute) -> NSLayoutConstraint? {
        return constraints.filter { $0.firstAttribute == attr }.first
    }
    
    /// Set corder radius for specific corners
    /// - Parameters:
    ///   - corners:
    ///   - radius:
    func setCornerRadius(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
    
    /// Set layer border style
    /// - Parameters:
    ///   - color:
    ///   - width:
    func setBorder(with color: UIColor, width: CGFloat) {
        layer.borderColor = color.cgColor
        layer.borderWidth = width
    }

    /// set Linear Gradient
    /// - Parameters:
    ///   - colors:
    ///   - locations:
    ///   - startPoint:
    ///   - endPoint:
    ///   - transform:
    ///   - insetBy:
    @discardableResult
    func setLinearGradient(
        colors: [UIColor],
        locations: [Double] = [0, 1],
        startPoint: CGPoint? = nil,
        endPoint: CGPoint? = nil,
        transform: CGAffineTransform? = nil,
        insetBy: (dx: CGFloat, dy: CGFloat)? = nil
    ) -> CAGradientLayer {
        let gradientLayer = UIView.createGradientLayer(
            bounds: bounds,
            colors: colors,
            locations: locations,
            startPoint: startPoint,
            endPoint: endPoint,
            transform: transform,
            insetBy: insetBy)
        
        // Remove old gradient layer if any
        if let sublayer = layer.sublayers?.first as? GradientLayer {
            sublayer.removeFromSuperlayer()
        }
        layer.insertSublayer(gradientLayer, at: 0)
        
        return gradientLayer
    }
}

// MARK: varible for extension UIView.

extension UIView {
    
    /// return identifier for view as self.
    open var identifier: String {
        return String(describing: self)
    }
    
    /// return UIImage form UIView.
    var image: UIImage? {
        if #available(iOS 10.0, *) {
            let renderer = UIGraphicsImageRenderer(bounds: bounds)
            return renderer.image { layer.render(in: $0.cgContext) }
        } else {
            defer { UIGraphicsEndImageContext() }
            UIGraphicsBeginImageContext(bounds.size)
            guard let context = UIGraphicsGetCurrentContext() else { return nil }
            layer.render(in: context)
            return UIGraphicsGetImageFromCurrentImageContext()
        }
    }
}

// MARK: Static and open funtion.

extension UIView {
    
    /// Create gradient Image
    /// - Parameters:
    ///   - bounds:
    ///   - colors:
    ///   - locations:
    ///   - startPoint:
    ///   - endPoint:
    ///   - transform:
    ///   - insetBy:
    static func createGradientImage(
        bounds: CGRect,
        colors: [UIColor],
        locations: [Double] = [0, 1],
        startPoint: CGPoint? = nil,
        endPoint: CGPoint? = nil,
        transform: CGAffineTransform? = nil,
        insetBy: (dx: CGFloat, dy: CGFloat)? = nil
    ) -> UIImage? {
        return createGradientLayer(
            bounds: bounds,
            colors: colors,
            locations: locations,
            startPoint: startPoint,
            endPoint: endPoint,
            transform: transform,
            insetBy: insetBy
        ).toImage()
    }
    
    /// Create gradient layer
    /// - Parameters:
    ///   - bounds:
    ///   - colors:
    ///   - locations:
    ///   - startPoint:
    ///   - endPoint:
    ///   - transform:
    ///   - insetBy:
    static func createGradientLayer(
        bounds: CGRect,
        colors: [UIColor],
        locations: [Double] = [0, 1],
        startPoint: CGPoint? = nil,
        endPoint: CGPoint? = nil,
        transform: CGAffineTransform? = nil,
        insetBy: (dx: CGFloat, dy: CGFloat)? = nil
    ) -> CAGradientLayer {
        var canvasBounds = bounds
        if let insetBy = insetBy {
            canvasBounds = bounds.insetBy(dx: insetBy.dx*bounds.width, dy: insetBy.dy*bounds.height)
        }
        
        let gradientLayer = GradientLayer()
        gradientLayer.frame = canvasBounds
        gradientLayer.colors = colors.map { $0.cgColor }
        gradientLayer.locations = locations.map { NSNumber(value: $0) }
        
        if let startPoint = startPoint {
            gradientLayer.startPoint = startPoint
        }
        
        if let endPoint = endPoint {
            gradientLayer.endPoint = endPoint
        }
        
        if let transform = transform {
            gradientLayer.transform = CATransform3DMakeAffineTransform(transform)
        }
        
        return gradientLayer
    }
    
    /// Load Xib from name
    /// - Parameters:
    ///   - nibNamed: string
    ///   - bundle:bundle
    static func loadFrom<T: UIView>(nibNamed: String, bundle : Bundle? = nil) -> T? {
        let nib = UINib(nibName: nibNamed, bundle: bundle)
        return nib.instantiate(withOwner: nil, options: nil)[0] as? T
    }
    
    /// Set box shadow
    /// - Parameters:
    ///   - offset:
    ///   - color:
    ///   - opacity:
    ///   - blur:
    open func setShadow(offset: CGSize, color: UIColor, opacity: Float, blur: CGFloat) {
        let shadowPath = UIBezierPath(roundedRect: layer.bounds, cornerRadius: layer.cornerRadius)
        layer.masksToBounds = false
        layer.shadowColor = color.cgColor
        layer.shadowOffset = offset
        layer.shadowOpacity = opacity
        layer.shadowRadius = blur
        layer.shadowPath = shadowPath.cgPath
    }
}
