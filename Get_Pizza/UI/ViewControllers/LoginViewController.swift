//
//  LoginViewController.swift
//  Get_Pizza
//
//  Created by Jonathan Green on 10/7/15.
//  Copyright (c) 2015 Jonathan Green. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController,UITextFieldDelegate {

    @IBOutlet weak var login: DesignableButton!
    
    @IBOutlet weak var username: UITextField!

    @IBOutlet weak var password: UITextField!
    
    
    override func viewWillAppear(animated: Bool) {
        
        self.navigationController?.navigationBarHidden = true
    }
    
    override func viewDidLoad() {
    
        username.delegate = self
        password.delegate = self
        
        login.addTarget(self, action: "goToHome", forControlEvents: .TouchUpInside)
        
    
}
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        username.resignFirstResponder()
        password.resignFirstResponder()
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()

        return true
    }
    
    
    func goToHome() {
        
        let home = self.storyboard!.instantiateViewControllerWithIdentifier("home") as! HomeViewController
        self.navigationController?.radialPushViewController(home)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
