//
//  Tweet.swift
//  twitterClient
//
//  Created by The Vinh Duong on 3/26/16.
//  Copyright © 2016 Cititech. All rights reserved.
//

import UIKit


class Tweet: NSObject {
    
    var profileImageUrl: NSURL?
    var user: NSDictionary?
    var name: NSString?
    var screenName: NSString?
    var text: NSString?
    var timestamp: NSDate?
    var retweetCount: Int = 0
    var favoritesCount: Int = 0

    init(dictionary: NSDictionary) {
        
        let user = dictionary["user"] as! NSDictionary
        let profileImageString = user["profile_image_url"] as! String
        profileImageUrl = NSURL(string: profileImageString)
        name = user["name"] as? String
        text = dictionary["text"] as? String
        screenName = user["screen_name"] as? String
        retweetCount = (dictionary["retweet_count"] as? Int) ?? 0
        favoritesCount = (dictionary["favourites_count"] as? Int) ?? 0
        
        
        let timestampString = dictionary["created_at"] as? String
        
        if let timestampString = timestampString{
            let formatter = NSDateFormatter()
            formatter.dateFormat = "EEE MM d HH:mm:ss Z y"
            timestamp = formatter.dateFromString(timestampString)
        }
        
    }
    
    class func tweetsWithArray(dictionaries: [NSDictionary]) -> [Tweet]{
        var tweets = [Tweet]()
        
        for dictionary in dictionaries {
            let tweet = Tweet(dictionary: dictionary)
            tweets.append(tweet)
        }
        
        return tweets
    }
}
