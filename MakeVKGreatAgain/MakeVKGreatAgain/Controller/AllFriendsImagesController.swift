//
//  AllFriendsImagesController.swift
//  MakeVKGreatAgain
//
//  Created by n.perezhogin on 26.02.2020.
//  Copyright © 2020 n.perezhogin. All rights reserved.
//

import UIKit
import Kingfisher

class AllFriendsImagesController: UIViewController {
    var friendImagesArray: [Photo] = []
    
    let cache = ImageCache.default
    
    @IBOutlet weak var friendImageView: FullScreenImageView!
    
    @IBOutlet weak var likeButtonTitle: LikeButton!
    @IBAction func likeButton(_ sender: Any) {
        likeButtonTitle.likedAction()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cache.retrieveImage(forKey: friendImagesArray[0].imageUrl) { result in
            switch result {
            case .success(let value):
                self.friendImageView.image = value.image

            case .failure(let error):
                print(error)
            }
        }
        
        friendImageView.imageArray = friendImagesArray
    }

}
