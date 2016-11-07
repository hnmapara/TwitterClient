//
//  TweetsViewController.swift
//  SimpleTwitter
//
//  Created by Harshit Mapara on 10/29/16.
//  Copyright © 2016 Harshit Mapara. All rights reserved.
//

import UIKit

class TweetsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, TweetsTableViewCellDelegate, ComposeViewControllerDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    var isHomeTimeline : Bool!
    var isMentionsTimeline : Bool!
    
    var tweets:[Tweet]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 110
        
        if isHomeTimeline == true {
            TwitterClient.sharedInstance?.homeTimeLine(success: { (tweets: [Tweet])->() in
                
                self.reloadFetchedTweets(tweets: tweets)
                }, failure: {(error: Error) -> () in
                    print("error : \(error.localizedDescription)")
            })
        } else {
            TwitterClient.sharedInstance?.mentionTimeLine(success: { (tweets: [Tweet])->() in
                
                self.reloadFetchedTweets(tweets: tweets)
                }, failure: {(error: Error) -> () in
                    print("error : \(error.localizedDescription)")
            })
        }
    }
    
    private func reloadFetchedTweets(tweets: [Tweet]) {
        //            for tweet in tweets {
        //                print("\(tweet.text!)")
        //            }
        self.tweets = tweets
        self.tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tweets != nil {
            return tweets.count
        }
        return 0
    }
    
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TweetCell", for: indexPath) as! TweetViewCell
        cell.delegate = self;
        cell.tweet = tweets[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailViewController = self.storyboard!.instantiateViewController(withIdentifier: "TweetDetailViewControllerId") as! TweetDetailViewController
        detailViewController.tweet = tweets[indexPath.row]
        tableView.deselectRow(at: indexPath, animated: true)
        self.navigationController?.pushViewController(detailViewController, animated: true)
    }
    
    

    @IBAction func onTapNewTweetAction(_ sender: AnyObject) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "composeViewController.identifier") as! ComposeViewController!
        vc?.delegate = self;
        navigationController?.pushViewController(vc!, animated: true)
    }
    
    func onNewTweet(tweet: Tweet?, viewController: ComposeViewController) {
        if tweet != nil {
            tweets.insert(tweet!, at: 0)
            tableView.reloadData()
        }
        
    }
    
    @IBAction func onLogout(_ sender: AnyObject) {
        TwitterClient.sharedInstance?.logout()
    }
    
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        let detailViewController = segue.destination as! TweetDetailViewController
//        let cell = sender as! UITableViewCell
//        let indexPath = tableView.indexPath(for: cell)
//        detailViewController.tweet = tweets![indexPath!.row]
//    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func reply(tweet: Tweet?, cell: TweetViewCell) {
        let indexPath = tableView.indexPath(for: cell)
        print("Reply to \(tweets[(indexPath?.row)!].text)")
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "composeViewController.identifier") as! ComposeViewController!
        vc?.delegate = self
        vc?.replyTo = tweets[(indexPath?.row)!].user?.screenName
        vc?.replyToId = tweets[(indexPath?.row)!].id
        navigationController?.pushViewController(vc!, animated: true)
    }
    
    func like(tweet: Tweet?, cell: TweetViewCell) {
        let indexPath = tableView.indexPath(for: cell)
        let tweet = tweets[(indexPath?.row)!];
        
        TwitterClient.sharedInstance?.handleLike(like: !(tweet.favorited), id: tweet.id!, success: { (tweet: Tweet?) in
            
            self.tweets[(indexPath?.row)!].favorited = tweet!.favorited
            self.tweets[(indexPath?.row)!].favCount = tweet!.favCount
            self.tableView.reloadData();
        }) { (error: Error?) in
            print(error?.localizedDescription)
        }
    }
    
    func retweet(tweet: Tweet?, cell: TweetViewCell) {
        let indexPath = tableView.indexPath(for: cell)
        let tweet = tweets[(indexPath?.row)!];
        
        TwitterClient.sharedInstance?.handleRetweet(retweet: !(tweet.retweeted), id: tweet.id!, success: { (tweet: Tweet?) in
            
            self.tweets[(indexPath?.row)!].retweeted = tweet!.retweeted;
            self.tweets[(indexPath?.row)!].retweetCount = tweet!.retweetCount;
            self.tableView.reloadData()
            
        }) { (error: Error?) in
            print(error?.localizedDescription)
        }
    }

}
