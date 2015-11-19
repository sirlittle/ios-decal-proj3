//
//  DetailViewController.swift
//  Photos
//
//  Created by Salil Vanvari on 11/17/15.
//  Copyright © 2015 iOS DeCal. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    var photo:Photo?
    var photos:[Photo]!

    @IBOutlet weak var instaImage: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var numberOfLikes: UILabel!
    @IBOutlet weak var likeButton: UIButton!
    @IBAction func likeMe(sender: UIButton) {
        if(photo!.liked){
            photo!.liked = false
            likeButton.setTitle("Like", forState: .Normal)
            numberOfLikes.text = String((photo?.likes)!)

        }
        else{
            photo!.liked = true
            likeButton.setTitle("Unlike", forState: .Normal)
            numberOfLikes.text = String((photo?.likes)! + 1)

        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        PhotosCollectionViewController.loadImageForCell(photo!, imageView: instaImage)
        usernameLabel.text = photo?.username!
        var num = 0
        if(photo!.liked){
            likeButton.setTitle("Unlike", forState: .Normal)
            num = 1;
        }
        else{
            likeButton.setTitle("Like", forState: .Normal)
        }
        numberOfLikes.text = String((photo?.likes)! + num)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if( segue.identifier! == "back"){
            let nav = segue.destinationViewController as! PhotosCollectionViewController
            nav.loaded = true
            nav.photos = self.photos
        }

    }

}
