//
//  TweetDetailViewController.swift
//  SimpleTwitter
//
//  Created by Harshit Mapara on 10/29/16.
//  Copyright © 2016 Harshit Mapara. All rights reserved.
//

import UIKit
import AFNetworking

class TweetDetailViewController: UIViewController {

    
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var authorName: UILabel!
    @IBOutlet weak var authorScreenName: UILabel!
    @IBOutlet weak var tweetText: UILabel!
    @IBOutlet weak var tweetTime: UILabel!
    @IBOutlet weak var retweetCount: UILabel!
    @IBOutlet weak var favoriteCount: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    
    var tweet: Tweet!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if tweet.userImageUrl != nil {
            self.userImage.setImageWith(tweet.userImageUrl!)
        }
        if tweet.authorName != nil {
            self.authorName.text = tweet.authorName!
        }
        if tweet.authorScreenName != nil {
            self.authorScreenName.text = "@\(tweet.authorScreenName!)"
        }
        if tweet.text != nil {
            self.tweetText.text = tweet.text!
        }
        
        if tweet.timeStamp != nil {
            let formatter = DateFormatter()
            formatter.dateFormat = "MM/dd/yy"
            self.tweetTime.text = formatter.string(from: tweet.timeStamp!)
        }
        
        self.favoriteCount.text = String(tweet.favoriteCount)
        self.retweetCount.text = String(tweet.retweetCount)
        //            favoriteCount.text = tweet.favoriteCount as! String
        //            retweetCount.text = tweet.retweetCount as! String

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func onFavorite(_ sender: AnyObject) {
        TwitterClient.sharedInstance?.favoriteThisTweet(with: tweet.id, success: {
            
            }, failure: { (Error) in
                
        })
    }
}
