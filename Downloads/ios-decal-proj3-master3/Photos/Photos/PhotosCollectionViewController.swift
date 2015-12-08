//
//  PhotosCollectionViewController.swift
//  Photos
//
//  Created by Gene Yoo on 11/3/15.
//  Copyright © 2015 iOS DeCal. All rights reserved.
//

import UIKit

class PhotosCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout{

    var photos = [Photo]()
    

    override func viewDidLoad() {
        super.viewDidLoad()
//
        let api = InstagramAPI()
        api.loadPhotos(didLoadPhotos)
        self.collectionView!.delegate = self


    }
    //to identify the number of items that are to be displayed in each section
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let photoCollectionCell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath:indexPath) as! PhotosCollectionViewCell
        loadImageForCell(photos[indexPath.row], imageView: photoCollectionCell.photo)
        return photoCollectionCell
    }
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        performSegueWithIdentifier("Segue", sender: photos[indexPath.row])
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        let photodetailView = segue.destinationViewController as! ViewController
        photodetailView.photo = sender as! Photo
    }
    
    
    /* 
     * IMPLEMENT ANY COLLECTION VIEW DELEGATE METHODS YOU FIND NECESSARY
     * Examples include cellForItemAtIndexPath, numberOfSections, etc.
     */
    
    /* Creates a session from a photo's url to download data to instantiate a UIImage. 
       It then sets this as the imageView's image. */
    
    func loadImageForCell(photo: Photo, imageView: UIImageView) {
        let task = NSURLSession.sharedSession().dataTaskWithURL(NSURL(string: photo.url)!) {
            (data: NSData?, response: NSURLResponse?, error: NSError?) -> Void in
            if error == nil {
                //let images = UIImage(data: data!)
                imageView.image = UIImage(data: data!)
            }
        }
        task.resume()
    }



    
    /* Completion handler for API call. DO NOT CHANGE */
    func didLoadPhotos(photos: [Photo]) {
        self.photos = photos
        self.collectionView!.reloadData()
    }

    
}

