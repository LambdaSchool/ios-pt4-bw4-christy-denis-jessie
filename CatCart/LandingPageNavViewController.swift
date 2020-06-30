//
//  LandingPageNavViewController.swift
//  CatCart
//
//  Created by Jessie Ann Griffin on 6/17/20.
//  Copyright © 2020 CatCartCo. All rights reserved.
//

import UIKit

class LandingPageNavViewController: UINavigationController {

    var userController: UserController?
    var user: User?

    override func viewDidLoad() {
        super.viewDidLoad()
        let landingPageVC = viewControllers.first as? LandingPageViewController
        landingPageVC?.userController = userController
    }
}
