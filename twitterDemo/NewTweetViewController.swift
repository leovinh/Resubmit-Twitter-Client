//
//  NewTweetViewController.swift
//  twitterClient
//
//  Created by The Vinh Duong on 3/26/16.
//  Copyright © 2016 Cititech. All rights reserved.
//

import UIKit

@objc protocol NewTweetViewControllerDelegate {
    optional func newTweet(newTweetViewController: NewTweetViewController, didUpdateTweet newTweet: Tweet)
}

class NewTweetViewController: UIViewController, UITextViewDelegate {

    @IBOutlet weak var newTweetTextField: UITextView!
    @IBOutlet weak var wordCounterLabel: UILabel!
    var numberCharacters: Int!
    
    weak var delegate: NewTweetViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newTweetTextField.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func textViewDidChange(textView: UITextView) {
        let text = newTweetTextField.text
        numberCharacters = text.characters.count
        wordCounterLabel.text = String (format: "%03d / 140", numberCharacters)
        
    }
    
    func textViewDidBeginEditing(textView: UITextView) {
        newTweetTextField.text = nil
        wordCounterLabel.text = "000 / 140"
    }
    

    @IBAction func onSendNewTweet(sender: AnyObject) {
        TwitterClient.sharedInstance.postNewTweet(newTweetTextField.text, success: { (NewTweet: Tweet) -> () in
            self.delegate?.newTweet!(self, didUpdateTweet: NewTweet)
            self.navigationController?.popToRootViewControllerAnimated(true)
        }) { (error: NSError) -> () in
            print("error: \(error.localizedDescription)")
        }
        
    }
   

}
