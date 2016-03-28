//
//  TweetTableViewCell.swift
//  twitterClient
//
//  Created by The Vinh Duong on 3/26/16.
//  Copyright © 2016 Cititech. All rights reserved.
//

import UIKit
import AFNetworking

class TweetTableViewCell: UITableViewCell {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var tweetTextLabel: UILabel!
    @IBOutlet weak var screennameLabel: UILabel!
    @IBOutlet weak var timestampLabel: UILabel!
    
    var tweet: Tweet! {
        didSet{
           
            if let tweetText = tweet.text as? String {
                tweetTextLabel.text = tweetText
            }
            
            profileImageView.setImageWithURL(tweet.profileImageUrl!)
            profileImageView.layer.cornerRadius = 5
            profileImageView.clipsToBounds = true
            
            if let name = tweet.name as? String {
                nameLabel.text = name
            }
            if let screenName = tweet.screenName as? String {
                screennameLabel.text = "@\(screenName)"
            }
            
            timestampLabel.text = calculateTime(NSDate().timeIntervalSinceDate(tweet.timestamp!))

        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func calculateTime(timestamp: NSTimeInterval) -> String {
            
            let ti = NSInteger(timestamp)
            let minutes = (ti / 60) % 60
            let hours = (ti / 3600)
        
        if minutes > 0 && hours <= 0 {
            return String(format: "%0.1dm",minutes)
        } else if (hours < 24 || hours > 0) {
            return String(format: "%0.2dh", hours)
        } else if (minutes == 0 && hours == 0){
            return "seconds"
        } else {
          return "\(hours/86400)d"
        }
    }

}
