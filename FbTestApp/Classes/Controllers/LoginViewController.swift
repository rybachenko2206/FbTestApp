//
//  LoginViewController.swift
//  FbTestApp
//
//  Created by Roman Rybachenko on 2/2/17.
//  Copyright © 2017 Roman Rybachenko. All rights reserved.
//

import UIKit
import FacebookLogin

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
    
    
    // MARK: Action funcs
    @IBAction func loginButtonTapped(_ sender: GradientButton) {
        let loginManager = LoginManager()
        
        loginManager.logIn([.publicProfile],
                           viewController: self,
                           completion: {(result: LoginResult) -> Void in
                            
                            switch result {
                                case .failed(let error):
                                    print("login error = \(error)")
                                case .cancelled:
                                    print("User cancelled login.")
                                case .success(let grantedPermissions, let declinedPermissions, let accessToken):
                                    print("Logged in!")
                                    print("~~grantedPermissions = \(grantedPermissions)")
                                    print("~~declinedPermissions = \(declinedPermissions)")
                                    print("~~accessToken = \(accessToken)")
                                
                                    self.dismiss(animated: true, completion: nil)
                            }
        })
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
