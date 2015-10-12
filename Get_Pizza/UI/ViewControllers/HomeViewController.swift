//
//  HomeViewController.swift
//  Get_Pizza
//
//  Created by Jonathan Green on 10/7/15.
//  Copyright © 2015 Jonathan Green. All rights reserved.
//

import UIKit
import BTNavigationDropdownMenu


class HomeViewController: UIViewController,UITableViewDataSource,UITableViewDelegate{
    
    @IBOutlet weak var tableView: UITableView!
    
    let items = ["Home", "Orders", "Account", "Logout"]
    
    
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
        
        cell.cardPayBtn.addTarget(self, action: "goToCardPay", forControlEvents: .TouchUpInside)
        
    
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    
    func goToCardPay() {
        
        let pay = self.storyboard!.instantiateViewControllerWithIdentifier("pay") as! PayViewController
        self.navigationController?.radialPushViewController(pay)
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
