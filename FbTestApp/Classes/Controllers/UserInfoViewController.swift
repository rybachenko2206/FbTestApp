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

class UserInfoViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let accessToken = AccessToken.current {
            let userProfile = UserProfile()
            userProfile.getProfile()
            
        } else {
            let loginVc = UIStoryboard.main().instantiateViewController(withIdentifier: LoginViewController.storyboardIdentifier)
            present(loginVc, animated: false, completion: nil)
        }
    }

    

}
