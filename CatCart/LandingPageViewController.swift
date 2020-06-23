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

//    static func goToLandingPage() -> LandingPageViewController {
//        let storyboard = UIStoryboard(name: "LandingPage", bundle: nil)
//        let landingPageVC = storyboard.instantiateViewController(withIdentifier: "LandingPageViewController") as! LandingPageViewController
//        return landingPageVC
//    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }


    @IBAction func showLogin() {
        let loginVC = UserLoginViewController.newLogin()
        present(loginVC, animated: true, completion: nil)
    }



    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
