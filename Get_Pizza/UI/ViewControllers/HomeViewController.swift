//
//  HomeViewController.swift
//  Get_Pizza
//
//  Created by Jonathan Green on 10/7/15.
//  Copyright © 2015 Jonathan Green. All rights reserved.
//

import UIKit
import BTNavigationDropdownMenu
import PassKit
import Stripe
import Parse
import Bolts


class HomeViewController: UIViewController,UITableViewDataSource,UITableViewDelegate{
    
    @IBOutlet weak var tableView: UITableView!
    
    let items = ["Home", "Orders", "Account", "Logout"]
    
    let SupportedPaymentNetworks = [PKPaymentNetworkVisa,PKPaymentNetworkMasterCard, PKPaymentNetworkAmex]
    let ApplePaySwagMerchantID = "merchant.com.getpizza"
    
    
    override func viewWillAppear(animated: Bool) {
        
        self.navigationController?.navigationBarHidden = false
        self.navigationItem.setHidesBackButton(true, animated: false)
    }
    
    override func viewDidAppear(animated: Bool) {
        
        let menuView = BTNavigationDropdownMenu(title: items.first!, items: items)
        
        menuView.cellSelectionColor = tableView.backgroundColor
        
        self.navigationItem.titleView = menuView
        
        menuView.didSelectItemAtIndexHandler = {(indexPath: Int) -> () in
            print("Did select item at index: \(indexPath)")
            
            if indexPath == 3 {
                
                self.navigationController?.navigationBarHidden = true
                
                let logout = self.storyboard!.instantiateViewControllerWithIdentifier("logout") as! LoginViewController
                
                self.navigationController?.radialPushViewController(logout)
           
                
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.enableRadialSwipe()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 5
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("homeCell") as! HomeCell
        
         cell.applePayBtn.hidden = !PKPaymentAuthorizationViewController.canMakePaymentsUsingNetworks(SupportedPaymentNetworks)
        
        cell.cardPayBtn.addTarget(self, action: "goToCardPay", forControlEvents: .TouchUpInside)
        cell.applePayBtn.addTarget(self, action: "goApplePay", forControlEvents: .TouchUpInside)
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    
    func goToCardPay() {
        
        let pay = self.storyboard!.instantiateViewControllerWithIdentifier("pay") as! PayViewController
        self.navigationController?.radialPushViewController(pay)
    }
    
    func goApplePay() {
        
        let request = PKPaymentRequest()
        request.merchantIdentifier = ApplePaySwagMerchantID
        request.supportedNetworks = SupportedPaymentNetworks
        //request.requiredShippingAddressFields = PKAddressField.All
        request.merchantCapabilities = PKMerchantCapability.Capability3DS
        request.countryCode = "US"
        request.currencyCode = "USD"
        
        request.paymentSummaryItems = [
            PKPaymentSummaryItem(label: "type of pizza goes here", amount: 5),
        ]
        
        let applePayController = PKPaymentAuthorizationViewController(paymentRequest: request)
        
        applePayController.delegate = self
        
        self.presentViewController(applePayController, animated: true, completion: nil)
        
    }
    
    func handleError(error: NSError) {
        UIAlertView(title: "Please Try Again",
            message: error.localizedDescription,
            delegate: nil,
            cancelButtonTitle: "OK").show()
        
    }
    
    func postStripeToken(token: STPToken) {
        
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
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}


extension HomeViewController: PKPaymentAuthorizationViewControllerDelegate {
    func paymentAuthorizationViewController(controller: PKPaymentAuthorizationViewController!, didAuthorizePayment payment: PKPayment!, completion: ((PKPaymentAuthorizationStatus) -> Void)!) {
        
        Stripe.createTokenWithPayment(payment) { (token: STPToken?, stripeError: NSError?) -> Void in
            
            if stripeError == nil {
                
                print("success")
                self.postStripeToken(token!)
            }else {
                
                print("something went wrong")
                self.handleError(stripeError!)
            }
        }
        
        completion(PKPaymentAuthorizationStatus.Success)
    }
    
    func paymentAuthorizationViewControllerDidFinish(controller: PKPaymentAuthorizationViewController!) {
        controller.dismissViewControllerAnimated(true, completion: nil)
    }
    
}

