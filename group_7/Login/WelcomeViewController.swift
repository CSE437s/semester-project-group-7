//
//  WelcomeViewController.swift
//  group_7
//

import UIKit

extension UIButton {
    
    func applyShadowAndRoundedCorners() {
        backgroundColor = .systemBlue
        
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.3
        layer.shadowOffset = CGSize(width: 0, height: 4)
        layer.shadowRadius = 3
        
        layer.cornerRadius = 10
        layer.masksToBounds = false
        
        layer.shouldRasterize = true
        layer.rasterizationScale = UIScreen.main.scale
    }
}

extension UIView {
    func applyShadowAndCorners() {
        
        // Adding shadow
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.3
        // Offset the shadow to move it downwards. A positive y value moves the shadow down.
        layer.shadowOffset = CGSize(width: 0, height: 4)
        // The shadow radius helps in spreading the shadow outwards from the offset point.
        layer.shadowRadius = 3

        // Rounding corners
        layer.cornerRadius = 15

        // Mask to bounds needs to be false to allow the shadow to appear outside of the view bounds
        layer.masksToBounds = false

        // Important for performance
        layer.shouldRasterize = true
        layer.rasterizationScale = UIScreen.main.scale
    }
}

class WelcomeViewController: UIViewController {
    
    @IBOutlet weak var letsGoButton: UIButton!
    
    @IBOutlet weak var welcomeImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        letsGoButton.applyShadowAndRoundedCorners()
        
    }

}

