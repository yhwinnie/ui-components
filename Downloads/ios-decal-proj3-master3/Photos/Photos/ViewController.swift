//
//  ViewController.swift
//  Photos
//
//  Created by Winnie Wen on 11/17/15.
//  Copyright © 2015 iOS DeCal. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var photo: Photo!
    @IBOutlet weak var userLabel: UILabel!
    @IBOutlet weak var numLikes: UILabel!
    @IBAction func likeButton(sender: AnyObject) {
        
        self.photo.likes = self.photo.likes + 1
        numLikes.text = "\(self.photo.likes) Likes"
        Like.setTitle("Liked", forState: .Normal)
    }
    @IBOutlet weak var Like: UIButton!
    @IBOutlet weak var datePosted: UILabel!

    @IBOutlet weak var photoView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        loadImageForCell(self.photo, imageView: self.photoView)
        userLabel.text = self.photo.username
        numLikes.text! = "\(self.photo.likes) Likes"
        datePosted.text = self.photo.datePosted
        
        
        
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadImageForCell(photo: Photo, imageView: UIImageView) {
        let task = NSURLSession.sharedSession().dataTaskWithURL(NSURL(string: photo.url)!) {
            (data: NSData?, response: NSURLResponse?, error: NSError?) -> Void in
            if error == nil {
                imageView.image = UIImage(data: data!)
            }
        }
        task.resume()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
