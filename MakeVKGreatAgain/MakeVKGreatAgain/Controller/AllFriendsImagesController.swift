//
//  AllFriendsImagesController.swift
//  MakeVKGreatAgain
//
//  Created by n.perezhogin on 26.02.2020.
//  Copyright © 2020 n.perezhogin. All rights reserved.
//

import UIKit

class AllFriendsImagesController: UIViewController {
    var friendImagesArray: [Photo] = []
    
    @IBOutlet weak var friendImageView: FullScreenImageView!
    
    @IBOutlet weak var likeButtonTitle: LikeButton!
    @IBAction func likeButton(_ sender: Any) {
        likeButtonTitle.likedAction()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        friendImageView.image = friendImagesArray[0]
//        friendImageView.imageArray = friendImagesArray
    }

}
