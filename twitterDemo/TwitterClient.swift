//
//  TwitterClient.swift
//  twitterClient
//
//  Created by The Vinh Duong on 3/26/16.
//  Copyright © 2016 Cititech. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

let twitterConsumerKey = "NjnI7bZ808oRVxuYk3z0TU9RF"
let twitterConsumerSecret = "AkogAJMpT7xeCEswBXYNnwLLNLVqKlNa43PnKAZ5NWcvziAMpH"
let twitterBaseURL = NSURL(string: "https://api.twitter.com")

class TwitterClient: BDBOAuth1SessionManager {
    
    
    static let sharedInstance = TwitterClient(baseURL: twitterBaseURL, consumerKey: twitterConsumerKey, consumerSecret: twitterConsumerSecret)
    
    var loginSuccess: (() -> ())?
    var loginFailure: ((NSError!) -> ())?
    
    func login(success: () -> () ,failure: (NSError!) -> ()) {
        
        loginSuccess = success
        loginFailure = failure
        
        
        TwitterClient.sharedInstance.deauthorize()
        
       
        TwitterClient.sharedInstance.fetchRequestTokenWithPath("/oauth/request_token", method: "GET", callbackURL: NSURL(string: "twitterClient://oauth")!, scope: nil, success: { (requestToken: BDBOAuth1Credential!) -> Void in
            let url = NSURL(string: "https://api.twitter.com/oauth/authorize?oauth_token=\(requestToken.token)")!
            UIApplication.sharedApplication().openURL(url)
            
            }) { (error: NSError!) -> Void in
                print("error: \(error.localizedDescription)")
                self.loginFailure?(error)
        }
    
    }
    
    func handleOpenUrl(url: NSURL){
        let requestToken = BDBOAuth1Credential(queryString: url.query)
        fetchAccessTokenWithPath("oauth/access_token", method: "POST", requestToken: requestToken, success: { (accessToken: BDBOAuth1Credential!) -> Void in
            
            
            self.currentAccount({ (user: User) -> () in
                
                User.currentUser = user
                self.loginSuccess?()
            
            }, failure: { (error: NSError) -> () in
                self.loginFailure?(error)
            })
            
            }) { (error: NSError!) -> Void in
                self.loginFailure?(error)
            }
    }
    
    
    func homeTimeline(success: ([Tweet]) -> (), failure: (NSError) -> ()){
        GET("1.1/statuses/home_timeline.json", parameters: nil, progress: nil, success: { (task: NSURLSessionDataTask, response: AnyObject?) -> Void in
            let dictionaries = response as! [NSDictionary]
            let tweets = Tweet.tweetsWithArray(dictionaries)
            success(tweets)
            
            }, failure: { (task: NSURLSessionDataTask?, error: NSError) -> Void in
                print("error: \(error.localizedDescription)")
        })

    }
    
    func currentAccount(success: (User)->(), failure: (NSError) -> ()) {
        GET("1.1/account/verify_credentials.json", parameters: nil, progress: nil, success: { (task: NSURLSessionDataTask, response: AnyObject?) -> Void in
            let userDictionary = response as! NSDictionary
            let user = User(dictionary: userDictionary)
            
            success(user)
            
            }, failure: { (task: NSURLSessionDataTask?, error: NSError) -> Void in
             failure(error)
        })
    }
    
    func postNewTweet(status: String, success: Tweet -> (), failure: (NSError) -> ()) {
        let param = ["status": status]
        POST("1.1/statuses/update.json", parameters: param, progress: nil, success: { (task: NSURLSessionDataTask, response: AnyObject?) -> Void in
            let dictionary = response as! NSDictionary
            let newTweet = Tweet(dictionary: dictionary)
            success(newTweet)
            
            }) { (task: NSURLSessionDataTask?, error: NSError) -> Void in
                print("error: \(error.localizedDescription)")
        }
    }
    
    func logout(){
        User.currentUser = nil
        deauthorize()
        NSNotificationCenter.defaultCenter().postNotificationName(User.userDidLogoutNotification, object: nil)
    }
}
