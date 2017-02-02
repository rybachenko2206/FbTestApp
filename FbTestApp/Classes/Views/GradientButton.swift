//
//  GradientButton.swift
//  FbTestApp
//
//  Created by Roman Rybachenko on 2/2/17.
//  Copyright © 2017 Roman Rybachenko. All rights reserved.
//

import UIKit

class GradientButton: UIButton {

    override func awakeFromNib() {
        super.awakeFromNib()
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.bounds
        gradientLayer.colors = [UIColor.blue.cgColor, UIColor.yellow.cgColor]
        gradientLayer.startPoint = CGPoint.zero
        self.layer.insertSublayer(gradientLayer, at: 0)
        
        self.layer.cornerRadius = 6
        self.layer.masksToBounds = true
    }

}
