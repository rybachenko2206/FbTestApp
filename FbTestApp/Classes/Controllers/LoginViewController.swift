//
//  LoginViewController.swift
//  FbTestApp
//
//  Created by Roman Rybachenko on 2/2/17.
//  Copyright © 2017 Roman Rybachenko. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    // MARK: Outlets
    
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var loginButton: GradientButton!
    
    // MARK: Properties
    let motionMagnitude = 100

    
    // MARK: Overriden funcs
    override func viewDidLoad() {
        super.viewDidLoad()

        applyMotionEffect(toView: backgroundImageView, magnitude: Float(motionMagnitude))
    }
    

    // MARK: Private funcs
    private func applyMotionEffect(toView view: UIView, magnitude: Float) {
        let xMotion = UIInterpolatingMotionEffect(keyPath: "center.x", type: .tiltAlongHorizontalAxis)
        xMotion.minimumRelativeValue = -magnitude
        xMotion.maximumRelativeValue = magnitude
        
        let yMotion = UIInterpolatingMotionEffect(keyPath: "center.y", type: .tiltAlongVerticalAxis)
        yMotion.minimumRelativeValue = -magnitude
        yMotion.maximumRelativeValue = magnitude
        
        let motionEffectGroup = UIMotionEffectGroup()
        motionEffectGroup.motionEffects = [xMotion, yMotion]
        
        view.addMotionEffect(motionEffectGroup)
    }
}
