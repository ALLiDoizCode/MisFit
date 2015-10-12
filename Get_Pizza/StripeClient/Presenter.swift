//
//  Presenter.swift
//  Get_Pizza
//
//  Created by Jonathan Green on 10/12/15.
//  Copyright © 2015 Jonathan Green. All rights reserved.
//

import UIKit
import Stripe
import Parse
import Bolts

class Presenter: NSObject,STPPaymentCardTextFieldDelegate {
    
     let navTo:Nav = Nav()
    
    func handleError(error: NSError) {
        UIAlertView(title: "Please Try Again",
            message: error.localizedDescription,
            delegate: nil,
            cancelButtonTitle: "OK").show()
        
    }
    
    func applePay(payment:PKPayment,nav: UINavigationController,completion: ((PKPaymentAuthorizationStatus) -> Void)!){
        
        Stripe.createTokenWithPayment(payment) { (token: STPToken?, stripeError: NSError?) -> Void in
            
            if stripeError == nil {
                
                print("success")
                self.postStripeToken(token!,nav: nav)
            }else {
                
                print("something went wrong")
                self.handleError(stripeError!)
            }
        }
        
        completion(PKPaymentAuthorizationStatus.Success)
    }
    
    func card(email:UITextField,date:UITextField,number:UITextField,cvc:UITextField,nav:UINavigationController){
        
        // Initiate the card
        let stripCard = STPCard()
        
        // Split the expiration date to extract Month & Year
        if date.text!.isEmpty == false {
            let expirationDate = date.text!.componentsSeparatedByString("/")
            let expMonth = UInt(expirationDate[0])
            let expYear = UInt(expirationDate[1])
            
            // Send the card info to Strip to get the token
            stripCard.number = number.text
            stripCard.cvc = cvc.text
            stripCard.expMonth = expMonth!
            stripCard.expYear = expYear!
        }
        
        
        do {
            try stripCard.validateCardReturningError()
            STPAPIClient.sharedClient().createTokenWithCard(
                stripCard,
                completion: { (token: STPToken?, stripeError: NSError?) -> Void in
                    
                    if stripeError == nil {
                        
                        //print(token!)
                        
                        
                        self.postStripeToken(token!,nav:nav)
                        
                    }else {
                        
                        self.handleError(stripeError!)
                    }
            })
        } catch {
            print("there is error.")
        }
    }
    
    func postStripeToken(token: STPToken,nav:UINavigationController) {
        
        let params = ["token": token.tokenId]
        
        PFCloud.callFunctionInBackground("hello", withParameters: params) { (Response, error) -> Void in
            
            if (error == nil) {
                
                print(Response)
                
                SweetAlert().showAlert("Charge Success", subTitle: "Thanks For Saving A Misfit Pizza!", style: AlertStyle.Success)
                
                
            }else {
                
                print(Response)
                
                SweetAlert().showAlert("Something Went Wrong", subTitle: ":(", style: AlertStyle.Error)
                
                
            }
        }
        
    }

}
