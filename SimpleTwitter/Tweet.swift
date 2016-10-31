//
//  Tweet.swift
//  SimpleTwitter
//
//  Created by Harshit Mapara on 10/29/16.
//  Copyright © 2016 Harshit Mapara. All rights reserved.
//

import UIKit

class Tweet: NSObject {
    
    var id: Int64!
    var text : String?
    var timeStamp: Date?
    var retweetCount : Int = 0
    var favoriteCount : Int = 0
    var userImageUrl : URL?
    var authorName: String?
    var authorScreenName : String?
    
    init(dictionary: NSDictionary) {
        let twID = dictionary["id"]!
        id = (twID as! NSNumber).int64Value
        text = dictionary["text"] as? String
        retweetCount = (dictionary["retweet_count"] as? Int) ?? 0
        favoriteCount = (dictionary["retweet_count"] as? Int) ?? 0
        
        if let user = dictionary["user"] as? NSDictionary {
            let profileUrlString = user["profile_image_url_https"] as? String
            if let profileUrlString = profileUrlString {
                userImageUrl = URL(string: profileUrlString)
            }
            authorName = user["name"] as? String
            authorScreenName = user["screen_name"] as? String            
        }
        
        let timeStampString = dictionary["created_at"] as? String
        
        if let timeStampString = timeStampString {
            let formatter = DateFormatter()
            formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
            timeStamp = formatter.date(from: timeStampString)
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
