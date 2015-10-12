//
//  Nav.swift
//  Get_Pizza
//
//  Created by Jonathan Green on 10/12/15.
//  Copyright © 2015 Jonathan Green. All rights reserved.
//

import UIKit

class Nav: NSObject {

    
    func goToHome(nav:UINavigationController) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
        let home = storyboard.instantiateViewControllerWithIdentifier("home") as! HomeViewController
        nav.radialPushViewController(home)
    }
    
    func goToCardPay(nav:UINavigationController) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
        let pay = storyboard.instantiateViewControllerWithIdentifier("pay") as! PayViewController
        nav.radialPushViewController(pay)
    }
    
    func login(nav:UINavigationController){
        
        let storyboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
        let login = storyboard.instantiateViewControllerWithIdentifier("login") as! LoginViewController
        nav.radialPushViewController(login)
    }
}
