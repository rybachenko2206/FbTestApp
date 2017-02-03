//
//  UserInfoViewController.swift
//  FbTestApp
//
//  Created by Roman Rybachenko on 2/2/17.
//  Copyright © 2017 Roman Rybachenko. All rights reserved.
//

import UIKit
import FacebookLogin
import FacebookCore
import SVProgressHUD

class UserInfoViewController: UIViewController {
    // MARK: Outlets

    @IBOutlet weak var coverImageView: UIImageView!
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var birthdayLabel: UILabel!
    @IBOutlet weak var placeLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        avatarImageView.layer.borderColor = UIColor.lightGray.cgColor
        avatarImageView.layer.backgroundColor = UIColor.white.cgColor
        avatarImageView.layer.borderWidth = 1
        avatarImageView.layer.masksToBounds = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        
        if AccessToken.current != nil {
            getUserProfile()
        } else {
            showLoginViewController(animated: false)
        }
    }
    
    
    // MARK: Action funcs

    @IBAction func logoutButtonTapped(_ sender: UIButton) {
        print("\n~~logout")
        LoginManager().logOut()
        
        showLoginViewController(animated: true)
    }
    
    // MARK: Private funcs
    private func showUserProfile(_ userProfile: UserProfile) {
        nameLabel.text = userProfile.response!.name
        genderLabel.text = userProfile.response!.gender
    }

    private func getUserProfile() {
        let userProfile = UserProfile()
        
        SVProgressHUD.show()
        userProfile.getProfile() { [unowned self] success in
            SVProgressHUD.dismiss()
            print("get profile success = \(success)")
            if success == true {
                self.showUserProfile(userProfile)
            } else {
                // TODO: show alert error
            }
        }
    }
    
    private func showLoginViewController(animated: Bool) {
        let loginVc = UIStoryboard.main().instantiateViewController(withIdentifier: LoginViewController.storyboardIdentifier)
        var viewControllers = self.navigationController?.viewControllers
        viewControllers?.append(loginVc)
        self.navigationController?.setViewControllers(viewControllers!, animated: animated)
    }
}
