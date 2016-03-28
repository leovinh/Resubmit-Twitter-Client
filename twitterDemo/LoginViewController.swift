//
//  LoginViewController.swift
//  twitterClient
//
//  Created by The Vinh Duong on 3/26/16.
//  Copyright © 2016 Cititech. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    
    @IBAction func onLogButton(sender: AnyObject) {
        
        TwitterClient.sharedInstance.login({ () -> () in
            self.performSegueWithIdentifier("LoginSegue", sender: nil)
            
        }) { (error: NSError!) -> () in
            print("error: \(error.localizedDescription)")
        }
        
        
    }

}
