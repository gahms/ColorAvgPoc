import UIKit

class HeaderImageCell: FullWidthCollectionViewCell {
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var textBackgroundView: UIView!
    @IBOutlet var textLabel: UILabel!
    var bgColor: UIColor = UIColor.red
    
    override func layoutSubviews() {
        let gradientView = textBackgroundView!
        
        let gradient = CAGradientLayer()
        gradient.frame = gradientView.bounds
        //let col = textBackgroundView.backgroundColor ?? UIColor.red
        gradient.colors = [
            bgColor.withAlphaComponent(0).cgColor,
            //bgColor.withAlphaComponent(0.5).cgColor,
            bgColor.cgColor
        ]

        //gradient.locations = [0, 0.5, 0.8]
        gradient.startPoint = CGPoint(x: 0.5, y: 0.0)
        gradient.endPoint = CGPoint(x: 0.5, y: 0.6)

        gradientView.layer.addSublayer(gradient)
    }
}
