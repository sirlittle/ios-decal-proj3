//
//  PhotosCollectionViewController.swift
//  Photos
//
//  Created by Gene Yoo on 11/3/15.
//  Copyright © 2015 iOS DeCal. All rights reserved.
//

import UIKit

class PhotosCollectionViewController: UICollectionViewController{
    var photos: [Photo]!
    var curNum: Int = 0
    @IBOutlet var myView: UICollectionView!
    var loaded: Bool = false
    override func viewDidLoad() {
        super.viewDidLoad()
        if(!loaded){
            let api = InstagramAPI()
            api.loadPhotos(didLoadPhotos)
            loaded = true
        }
        // FILL ME IN
    }

    /* 
     * IMPLEMENT ANY COLLECTION VIEW DELEGATE METHODS YOU FIND NECESSARY
     * Examples include cellForItemAtIndexPath, numberOfSections, etc. cellForItemAt, Number of items in section
     */

    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if(photos == nil){
            return 0
        }
        return photos.count
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! instaImageCell
        var heart = ""
        if(photos[indexPath.row].liked){
            heart = "💕"
        }
        cell.username.text = photos[indexPath.row].username + heart
        PhotosCollectionViewController.loadImageForCell(photos[indexPath.row], imageView: cell.InstaPic)

        return cell
    }
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        print("Selected \(indexPath.row) selected")
        curNum = indexPath.row
        performSegueWithIdentifier("detailSeg", sender: self);
        
        
    }
    /* Creates a session from a photo's url to download data to instantiate a UIImage. 
       It then sets this as the imageView's image. */
    class func loadImageForCell(photo: Photo, imageView: UIImageView) {
        let url = photo.url!
        let nurl = NSURL(string: url)
        let task = NSURLSession.sharedSession().dataTaskWithURL(nurl!) {
            (data: NSData?, response: NSURLResponse?, error: NSError?) -> Void in
            if(error == nil){
                do {
                    let priority = DISPATCH_QUEUE_PRIORITY_DEFAULT
                    dispatch_async(dispatch_get_global_queue(priority, 0)) {
                        dispatch_async(dispatch_get_main_queue()) {
                            imageView.image = UIImage(data: data!)
                        }
                    }
                }
            }
        }
        task.resume()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if( segue.identifier! == "detailSeg"){
            let nav = segue.destinationViewController as! DetailViewController
            nav.photo = photos[curNum]
            nav.photos = self.photos
        }
    }
    /* Completion handler for API call. DO NOT CHANGE */
    func didLoadPhotos(photos: [Photo]) {
        self.photos = photos
        self.collectionView!.reloadData()
    }
}

