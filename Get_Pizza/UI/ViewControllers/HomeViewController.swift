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
    
    override func viewDidAppear(animated: Bool) {
        
        let menuView = BTNavigationDropdownMenu(title: items.first!, items: items)
        
        menuView.cellSelectionColor = tableView.backgroundColor
        
        self.navigationItem.titleView = menuView
        
        menuView.didSelectItemAtIndexHandler = {(indexPath: Int) -> () in
            print("Did select item at index: \(indexPath)")
            
            if indexPath == 3 {
                
                let logout = self.storyboard!.instantiateViewControllerWithIdentifier("logout") as! LoginViewController
                
                self.navigationController?.showViewController(logout, sender: self)
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 5
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("homeCell")
        
        
        return cell!
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
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
