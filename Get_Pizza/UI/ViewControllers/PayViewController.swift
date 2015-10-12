//
//  PayViewController.swift
//  Get_Pizza
//
//  Created by Jonathan Green on 10/8/15.
//  Copyright © 2015 Jonathan Green. All rights reserved.
//

import UIKit
import Stripe

class PayViewController: UIViewController,UITableViewDelegate,UITextFieldDelegate,STPPaymentCardTextFieldDelegate {
    
    @IBOutlet weak var emailLbl: UITextField!
    
    @IBOutlet weak var cardLbl: UITextField!

    @IBOutlet weak var dateLbl: UITextField!
    
    @IBOutlet weak var cvcLbl: UITextField!
    
    @IBOutlet weak var payBtn: ZFRippleButton!
    
    let presenter:Presenter = Presenter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
       self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        
        emailLbl.delegate = self
        cardLbl.delegate = self
        dateLbl.delegate = self
        cvcLbl.delegate = self
        
    }

    @IBAction func pay(sender: AnyObject) {
        
       
        presenter.card(emailLbl,date: dateLbl,number: cardLbl,cvc: cvcLbl,nav: self.navigationController!)
       

    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        emailLbl.resignFirstResponder()
        cardLbl.resignFirstResponder()
        dateLbl.resignFirstResponder()
        cvcLbl.resignFirstResponder()
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        
        return true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
        
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
