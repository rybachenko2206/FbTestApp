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
import SDWebImage

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
        let titleStr = "Logout?"
        let msgStr = ""
        let ac = UIAlertController(title: titleStr, message: msgStr, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel",
                                         style: .cancel,
                                         handler: nil)
        ac.addAction(cancelAction)
        
        let yesAction = UIAlertAction(title: "YES",
                                      style: .default,
                                      handler: {action in
                                        
                                        LoginManager().logOut()
                                        self.showLoginViewController(animated: true)
        })
        ac.addAction(yesAction)
        
        present(ac, animated: true, completion: nil)
    }
    
    // MARK: Private funcs
    private func showUserProfile(_ userProfile: UserProfile) {
        nameLabel.text = userProfile.response!.name
        genderLabel.text = userProfile.response!.gender
        
        birthdayLabel.text = userProfile.response?.birthday == nil ? "" : userProfile.response!.birthday! as! String
        
        
        let avatarUrl = URL(string: userProfile.response!.avatarLink)
        avatarImageView.sd_setImage(with: avatarUrl)
        
        let coverUrl = URL(string: userProfile.response!.coverLink)
        coverImageView.sd_setImage(with: coverUrl)
    }

    private func getUserProfile() {
        let userProfile = UserProfile()
        
        SVProgressHUD.show()
        userProfile.getProfile() { [unowned self] success, error in
            SVProgressHUD.dismiss()
            print("get profile success = \(success)")
            if success == true {
                self.showUserProfile(userProfile)
            } else {
                self.showAlertWithError(error!)
            }
        }
    }
    
    private func showLoginViewController(animated: Bool) {
        let loginVc = UIStoryboard.main().instantiateViewController(withIdentifier: LoginViewController.storyboardIdentifier)
        var viewControllers = self.navigationController?.viewControllers
        viewControllers?.append(loginVc)
        self.navigationController?.setViewControllers(viewControllers!, animated: animated)
    }
    
    private func showAlertWithError(_ error: Error) {
        let title = "Error!"
        let msg = error.localizedDescription
        
        let ac = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        ac.addAction(okAction)
        
        present(ac, animated: true, completion: nil)
    }
}
