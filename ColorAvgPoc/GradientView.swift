import UIKit

// ref: https://stackoverflow.com/a/53441241/833197
class GradientView: UIView {

    var color: UIColor = .blue {
        didSet {
            startColor = color.withAlphaComponent(0)
            endColor = color
        }
    }
    
    var startColor: UIColor = .blue {
        didSet {
            setNeedsLayout()
        }
    }

    var endColor: UIColor = .green {
        didSet {
            setNeedsLayout()
        }
    }

    var startPoint: CGPoint = CGPoint(x: 0.5, y: 0.0) {
        didSet {
            setNeedsLayout()
        }
    }

    var endPoint: CGPoint = CGPoint(x: 0.5, y: 1.0) {
        didSet {
            setNeedsLayout()
        }
    }

    override class var layerClass: AnyClass {
        return CAGradientLayer.self
    }

    override func layoutSubviews() {
        let gradientLayer = layer as! CAGradientLayer
        gradientLayer.colors = [startColor.cgColor, endColor.cgColor]
        gradientLayer.startPoint = startPoint
        gradientLayer.endPoint = endPoint
    }
}
