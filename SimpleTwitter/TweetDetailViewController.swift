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
    @IBOutlet weak var likeIcon: UIImageView!
    @IBOutlet weak var replyIcon: UIImageView!
    @IBOutlet weak var retweetIcon: UIImageView!
    
    var tweet: Tweet!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        userImage.setImageWith((self.tweet!.user?.profileUrl)!)
        self.authorName.text = tweet!.user!.name
        self.authorScreenName.text = "@\(tweet!.user!.screenName!)"
        self.tweetText.text = tweet.text!
        
        self.tweetTime.text = tweet!.createdAtString;
        retweetCount.text = "\(tweet!.retweetCount)"
        favoriteCount.text = "\(tweet!.favCount)"
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

    func replyTapped(sender: Any?) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "composeViewController.identifier") as! ComposeViewController!
        vc?.replyTo = tweet?.user?.screenName
        vc?.replyToId = tweet?.id
        navigationController?.pushViewController(vc!, animated: true)
    }
    
    func likeTapped(sender: Any?) {
        TwitterClient.sharedInstance?.handleLike(like: !(tweet?.favorited)!, id: (tweet?.id!)!, success: { (tweet: Tweet?) in
            if (self.tweet?.favorited)! {
                self.likeIcon.image = UIImage(named: "likeGrey")
            } else {
                self.likeIcon.image = UIImage(named: "likeRed")
            }
            self.favoriteCount.text = "\(tweet!.favCount)"
            
        }) { (error: Error?) in
            print(error?.localizedDescription)
        }
    }
    
    func retweetTapped(sender: Any?) {
        TwitterClient.sharedInstance?.handleRetweet(retweet: !(tweet?.retweeted)!, id: (tweet?.id!)!, success: { (tweet: Tweet?) in
            if (self.tweet?.retweeted)! {
                self.retweetIcon.image = UIImage(named: "retweetGrey")
            } else {
                self.retweetIcon.image = UIImage(named: "retweetGreen")
            }
            self.retweetCount.text = "\(tweet!.retweetCount)"
            
        }) { (error: Error?) in
            print(error?.localizedDescription)
        }
    }
}
