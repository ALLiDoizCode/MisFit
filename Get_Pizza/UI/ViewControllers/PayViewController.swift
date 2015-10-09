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
    override func viewDidLoad() {
        super.viewDidLoad()
    
       self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        
        emailLbl.delegate = self
        cardLbl.delegate = self
        dateLbl.delegate = self
        cvcLbl.delegate = self
        
    }

    @IBAction func pay(sender: AnyObject) {
        
        // Initiate the card
        let stripCard = STPCard()
        
        // Split the expiration date to extract Month & Year
        if self.dateLbl.text!.isEmpty == false {
            let expirationDate = self.dateLbl.text!.componentsSeparatedByString("/")
            let expMonth = UInt(expirationDate[0])
            let expYear = UInt(expirationDate[1])
            
            // Send the card info to Strip to get the token
            stripCard.number = self.cardLbl.text
            stripCard.cvc = self.cvcLbl.text
            stripCard.expMonth = expMonth!
            stripCard.expYear = expYear!
        }
        
        
        do {
            try stripCard.validateCardReturningError()
            STPAPIClient.sharedClient().createTokenWithCard(
                stripCard,
                completion: { (token: STPToken?, stripeError: NSError?) -> Void in
                    
                    if stripeError == nil {
                        
                       print(token!)
                        
                    }else {
                        
                        self.handleError(stripeError!)
                    }
                    
                    //self.createBackendChargeWithToken(token!, completion: nil)
            })
        } catch {
            print("there is error.")
        }
        
       

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
    
    func handleError(error: NSError) {
        UIAlertView(title: "Please Try Again",
            message: error.localizedDescription,
            delegate: nil,
            cancelButtonTitle: "OK").show()
        
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
