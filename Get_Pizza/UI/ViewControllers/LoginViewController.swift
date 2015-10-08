//
//  LoginViewController.swift
//  Get_Pizza
//
//  Created by Jonathan Green on 10/7/15.
//  Copyright (c) 2015 Jonathan Green. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController,UITextFieldDelegate {

    
    @IBOutlet weak var username: UITextField!

    @IBOutlet weak var password: UITextField!
    
    override func viewDidLoad() {
        
        username.delegate = self
        password.delegate = self
        
    
        
        
}
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        username.resignFirstResponder()
        password.resignFirstResponder()
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()

        return true
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
