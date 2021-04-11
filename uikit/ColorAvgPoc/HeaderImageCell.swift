import UIKit

class HeaderImageCell: FullWidthCollectionViewCell {
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var textBackgroundView: UIView!
    @IBOutlet var textBackgroundGradientView: GradientView!
    @IBOutlet var textLabel: UILabel!
    //var bgColor: UIColor = UIColor.red
      
    /*
    override func layoutSubviews() {
        layer.cornerRadius = 16.0
        let gradientView = textBackgroundView!
        
        gradientView.backgroundColor = UIColor.clear
        let gradient = CAGradientLayer()
        gradient.frame = gradientView.bounds
        //let col = textBackgroundView.backgroundColor ?? UIColor.red
        gradient.colors = [
            bgColor.withAlphaComponent(0).cgColor,
            bgColor.withAlphaComponent(0.8).cgColor,
            bgColor.cgColor
        ]

        gradient.locations = [0, 0.5, 1]
        gradient.startPoint = CGPoint(x: 0.5, y: 0.0)
        gradient.endPoint = CGPoint(x: 0.5, y: 0.8)

        gradientView.layer.addSublayer(gradient)
    }
    */
}
