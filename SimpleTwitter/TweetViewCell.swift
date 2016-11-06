//
//  TweetViewCell.swift
//  SimpleTwitter
//
//  Created by Harshit Mapara on 10/29/16.
//  Copyright © 2016 Harshit Mapara. All rights reserved.
//

import UIKit
import AFNetworking

@objc protocol TweetsTableViewCellDelegate {
    @objc optional func reply(tweet: Tweet?, cell: TweetViewCell)
    @objc optional func like(tweet: Tweet?, cell: TweetViewCell)
    @objc optional func retweet(tweet: Tweet?, cell: TweetViewCell)
}

class TweetViewCell: UITableViewCell {
    
    
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userIdLabel: UILabel!
    @IBOutlet weak var tweetText: UILabel!
    @IBOutlet weak var timelabel: UILabel!
    @IBOutlet weak var favoriteImageButton: UIImageView!
    @IBOutlet weak var replyImageButton: UIImageView!
    @IBOutlet weak var retweetImageView: UIImageView!
    
    weak var delegate: TweetsTableViewCellDelegate?
    
    var tweet: Tweet! {
        didSet{
            userImage.setImageWith((tweet.user?.profileUrl!)!)
            userNameLabel.text = tweet.user!.name
            userIdLabel.text = "@\(tweet.user!.screenName!)"
            tweetText.text = tweet.text!
            
//            if tweet.timeStamp != nil {
//                let formatter = DateFormatter()
//                formatter.dateFormat = "MM/dd/yy"
//                timelabel.text = formatter.string(from: tweet.timeStamp!)
//            }
            
            
//            usernameLabel.text = tweet.user!.name
//            twitterHandleLabel.text = "@\(tweet.user!.screenName!)"
//            tweetLabel.text = tweet.text!
//            
            if tweet.favorited{
                favoriteImageButton.image = UIImage(named: "likeRed")
            } else {
                favoriteImageButton.image = UIImage(named: "likeGrey")
            }
            if tweet.retweeted{
                retweetImageView.image = UIImage(named: "retweetGreen")
            }else{
                retweetImageView.image = UIImage(named: "retweetGrey")
            }
            
            let replyGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(TweetViewCell.replyTapped(sender:)))
            replyImageButton.isUserInteractionEnabled = true
            replyImageButton.addGestureRecognizer(replyGestureRecognizer)
            
            let likeGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(TweetViewCell.likeTapped(sender:)))
            favoriteImageButton.isUserInteractionEnabled = true
            favoriteImageButton.addGestureRecognizer(likeGestureRecognizer)
            
            let retweetGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(TweetViewCell.retweetTapped(sender:)))
            retweetImageView.isUserInteractionEnabled = true
            retweetImageView.addGestureRecognizer(retweetGestureRecognizer)
        }
    }
        
    override func awakeFromNib() {
        super.awakeFromNib()
        userImage.layer.cornerRadius = 4
        userImage.clipsToBounds = true    
    }
    
    func replyTapped(sender: Any?) {
        delegate?.reply!(tweet: tweet, cell: self)
    }
    
    func likeTapped(sender: Any?) {
        delegate?.like!(tweet: tweet, cell: self)
    }
    
    func retweetTapped(sender: Any?) {
        delegate?.retweet!(tweet: tweet, cell: self)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    

}
