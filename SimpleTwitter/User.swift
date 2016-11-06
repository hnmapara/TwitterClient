//
//  User.swift
//  SimpleTwitter
//
//  Created by Harshit Mapara on 10/29/16.
//  Copyright © 2016 Harshit Mapara. All rights reserved.
//

import UIKit

class User: NSObject {
    
    var name: String?
    var screenName: String?
    var userDescription: String?
    var profileUrl : URL?
    var followers: Int?
    var following: Int?
    var tweets: Int?
    var id: Int?
    var tweetCount: String?
    var dictionary : NSDictionary?

    init(dictionary: NSDictionary) {
    
        self.dictionary = dictionary
        id = dictionary["id"] as? Int
        name = dictionary["name"] as? String
        screenName = dictionary["screen_name"] as? String
        followers = dictionary["followers_count"] as? Int
        following = dictionary["following"] as? Int
        if let status_count = dictionary["statuses_count"]{
            tweetCount = "\(status_count)"
        }
        
        let profileUrlString = dictionary["profile_image_url_https"] as? String
        if let profileUrlString = profileUrlString {
            profileUrl = URL(string: profileUrlString)
        }
        
        userDescription = dictionary["description"] as? String
    }
    
    static let userDidLogoutNotification = "UserDidLogout"
    static var _currentUser: User?
    class var currentUser : User? {
        get {
            if _currentUser == nil {
                let defaults = UserDefaults.standard
                let userData = defaults.object(forKey: "currentUserData") as? NSData
                if let userData = userData {
                    let dictionary = try! JSONSerialization.jsonObject(with: userData as Data, options: []) as! NSDictionary
                    _currentUser = User(dictionary: dictionary)
                }
            }
            return _currentUser
        }
        
        set(user) {
            _currentUser = user
            let defaults = UserDefaults.standard
            if let user = user {
                let data = try! JSONSerialization.data(withJSONObject: user.dictionary!, options: [])
                defaults.set(data, forKey: "currentUserData")
            } else {
                defaults.set(nil, forKey: "currentUserData")
            }
            defaults.synchronize()
            
        }
    }
}
