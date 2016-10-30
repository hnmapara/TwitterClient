//
//  TweetViewCell.swift
//  SimpleTwitter
//
//  Created by Harshit Mapara on 10/29/16.
//  Copyright © 2016 Harshit Mapara. All rights reserved.
//

import UIKit
import AFNetworking

class TweetViewCell: UITableViewCell {
    
    
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userIdLabel: UILabel!
    @IBOutlet weak var tweetText: UILabel!
    @IBOutlet weak var timelabel: UILabel!
    
    var tweet: Tweet! {
        didSet{
            if tweet.userImageUrl != nil {
                userImage.setImageWith(tweet.userImageUrl!)
            }
            if tweet.authorName != nil {
                userNameLabel.text = tweet.authorName!
            }
            if tweet.authorScreenName != nil {
                userIdLabel.text = "@\(tweet.authorScreenName!)"
            }
            if tweet.text != nil {
                tweetText.text = tweet.text!
            }
            
            if tweet.timeStamp != nil {
                let formatter = DateFormatter()
                formatter.dateFormat = "MM/dd/yy"
                timelabel.text = formatter.string(from: tweet.timeStamp!)
            }
        }
    }
        
    override func awakeFromNib() {
        super.awakeFromNib()
        userImage.layer.cornerRadius = 4
        userImage.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
