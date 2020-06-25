//
//  LandingPageViewController.swift
//  CatCart
//
//  Created by Jessie Ann Griffin on 6/17/20.
//  Copyright © 2020 CatCartCo. All rights reserved.
//

import UIKit

class LandingPageViewController: UIViewController {

    @IBOutlet weak var toLoginScreenButton: UIButton!
    @IBOutlet weak var toCreateAccountScreen: UIButton!

    var userController: UserController?
    var currentUser: User?

//    static func goToLandingPage() -> LandingPageViewController {
//        let storyboard = UIStoryboard(name: "LandingPage", bundle: nil)
//        let landingPageVC = storyboard.instantiateViewController(withIdentifier: "LandingPageViewController") as! LandingPageViewController
//        return landingPageVC
//    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if currentUser != nil {
            self.dismiss(animated: true, completion: nil)
        }
    }

    @IBAction func showLogin() {
        let loginVC = UserLoginViewController.newLogin()
        present(loginVC, animated: true, completion: nil)
    }
}
