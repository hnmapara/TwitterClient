//
//  ViewController.swift
//  SimpleTwitter
//
//  Created by Harshit Mapara on 10/28/16.
//  Copyright © 2016 Harshit Mapara. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

class LoginViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onLogin(_ sender: AnyObject) {
        let twitterClient = TwitterClient.sharedInstance
        
        twitterClient?.login(success: {
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
            }, failure: { (error:Error) ->() in
            print("error : \(error.localizedDescription)")
        })
        
    }
    
}

