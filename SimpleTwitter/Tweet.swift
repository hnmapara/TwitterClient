//
//  Tweet.swift
//  SimpleTwitter
//
//  Created by Harshit Mapara on 10/29/16.
//  Copyright © 2016 Harshit Mapara. All rights reserved.
//

import UIKit

class Tweet: NSObject {
    
    var id: Int?
    var user: User?
    
    var text: String?
    var createdAtString: String?
    //var createdAt: NSDate?
    //var retweetName: String? = nil
    //var replyName: String? = nil
    var favorited = false
    var retweeted = false
    var retweetCount = 0
    var favCount = 0
    
    init(dictionary: NSDictionary) {
        
        user = User(dictionary: dictionary["user"] as! NSDictionary)
        
        text = dictionary["text"] as? String
        id = dictionary["id"] as? Int
        favorited = dictionary["favorited"] as? Bool ?? false
        retweeted = dictionary["retweeted"] as? Bool ?? false
        //screenName = user!.screenName
        
        if let createdAtStr = dictionary["created_at"] as? String {
            createdAtString = createdAtStr
            //            createdAt = DateManager.defaultFormatter.dateFromString(createdAtString!)
        }
        if let retweetCountData = dictionary["retweet_count"] as? Int {
            retweetCount = retweetCountData
        } else {
            retweetCount = 0
        }
        if let favCountData = dictionary["favorite_count"] as? Int {
            favCount = favCountData
        } else {
            favCount = 0
        }
        
    }
    
    class func tweetsWithArray(dictionaries: [NSDictionary]) -> [Tweet] {
        var tweets = [Tweet]()
        
        for dictionary in dictionaries {
            let tweet = Tweet(dictionary: dictionary)
            tweets.append(tweet)
        }
        
        return tweets
    }

}
