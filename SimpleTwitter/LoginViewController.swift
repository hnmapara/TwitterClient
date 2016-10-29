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
        let twitterClient = BDBOAuth1SessionManager(baseURL: URL(string:"https://api.twitter.com")!, consumerKey: "exPArjPCUVwtqgtLdFDzOXNzx", consumerSecret: "wbQF3u3TqHQSNFoXHZDKFYVZTjS7kkJJ24xmCgwwicMzLtGbxa")
        
        twitterClient?.deauthorize()
        twitterClient?.fetchRequestToken(withPath: "oauth/request_token",
                                         method: "GET",
                                         callbackURL: URL(string: "twitterDemoMe://oauth"),
                                         scope: nil,
                                         success: { (requestToken: BDBOAuth1Credential?) -> Void in
                                            if(requestToken != nil && requestToken?.token != nil){
                                                print("success \(requestToken!.token)")
                                                let url = URL(string:"https://api.twitter.com/oauth/authorize?oauth_token=\(requestToken!.token!)")!
                                                UIApplication.shared.open(url, options: [:], completionHandler: { (isHandled) in
                                                    print("")
                                                })
                                            } else {
                                                print("token is empty")
                                            }
                                         },
                                         failure: { (error: Error?)->Void in
                                            print("error : \(error?.localizedDescription)")
                                        })
        
    }
    
}

