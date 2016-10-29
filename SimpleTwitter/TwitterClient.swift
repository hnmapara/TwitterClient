//
//  TwitterClient.swift
//  SimpleTwitter
//
//  Created by Harshit Mapara on 10/29/16.
//  Copyright © 2016 Harshit Mapara. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

class TwitterClient: BDBOAuth1SessionManager {
    
    static let sharedInstance = TwitterClient(baseURL: URL(string:"https://api.twitter.com")!, consumerKey: "exPArjPCUVwtqgtLdFDzOXNzx", consumerSecret: "wbQF3u3TqHQSNFoXHZDKFYVZTjS7kkJJ24xmCgwwicMzLtGbxa")
    
    var loginSuccess : (() -> ())?
    var loginFailure : ((Error) ->())?
    
    func logout() {
        User.currentUser = nil
        deauthorize()
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: User.userDidLogoutNotification), object: nil)
    }
    
    func login(success:@escaping () -> (), failure:@escaping (Error)->()) {
        loginSuccess = success
        loginFailure = failure
        
        deauthorize()
        fetchRequestToken(withPath: "oauth/request_token",
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
                                            self.loginFailure?(error!)
        })
    }
    
    func homeTimeLine(success : @escaping ([Tweet]) ->(), failure: @escaping (Error)->()) {
        get("1.1/statuses/home_timeline.json", parameters: nil, progress: nil, success: { (task:URLSessionDataTask, response :Any?) in
            //print("account: \(response)")
            let tweetDictionaries = response as! [NSDictionary]
            let tweets = Tweet.tweetsWithArray(dictionaries: tweetDictionaries)
            success(tweets)
            }, failure: { (task:URLSessionDataTask?, error:Error) in
                //print("error : \(error.localizedDescription)")
                failure(error)
        })
    }
    
    func currentAccount(success: @escaping (User) ->(), failure:@escaping (Error) ->()) {
        get("1.1/account/verify_credentials.json", parameters: nil, progress: nil, success: { (task:URLSessionDataTask, response :Any?) in
            //print("account: \(response)")
            let userDictionary = response as! NSDictionary
            let user = User(dictionary: userDictionary)
            
            success(user)
            print("name: \(user.name)")
            print("screenName: \(user.screenName)")
            print("profile url: \(user.profileUrl)")
            print("description: \(user.tagLine)")
            
            }, failure: { (task:URLSessionDataTask?, error:Error) in
                print("error : \(error.localizedDescription)")
                failure(error)
        })
    }
    
    func handleOpenUrl(url:URL) {
        let requestToken = BDBOAuth1Credential(queryString: url.query)
        fetchAccessToken(withPath: "oauth/access_token", method: "POST", requestToken: requestToken, success: { (accessToken:BDBOAuth1Credential?) in
            if (accessToken != nil) {
                print("got accessToken :")
                
                self.currentAccount(success: { (user: User) in
                        User.currentUser = user
                        self.loginSuccess?()
                    }, failure: { (error: Error) in
                        self.loginFailure?(error)
                })
                
            } else {
                print("failed :no accessToken")
            }
            }, failure: { (error : Error?) in
                self.loginFailure?(error!)
        })

    }    
}
