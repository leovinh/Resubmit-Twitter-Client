//
//  TweetDetailsViewController.swift
//  twitterClient
//
//  Created by The Vinh Duong on 3/26/16.
//  Copyright © 2016 Cititech. All rights reserved.
//

import UIKit

class TweetDetailsViewController: UIViewController {

    @IBOutlet weak var tweetTextLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var screennameLabel: UILabel!
    @IBOutlet weak var timestampLabel: UILabel!
    @IBOutlet weak var setImageToPreview: UIImageView!
    
    
    var tweet: Tweet!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tweetTextLabel.text = tweet.text as? String
        nameLabel.text = tweet.name as? String
        profileImageView.setImageWithURL(tweet.profileImageUrl!)
        profileImageView.layer.cornerRadius = 5
        profileImageView.clipsToBounds = true
        screennameLabel.text = tweet.screenName as? String
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
