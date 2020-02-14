//
//  FooterFriendImagesView.swift
//  MakeVKGreatAgain
//
//  Created by n.perezhogin on 14.02.2020.
//  Copyright © 2020 n.perezhogin. All rights reserved.
//

import UIKit

class FooterFriendImagesView: UICollectionReusableView {
    
    @IBOutlet weak var likeButtonTitle: LikeButton!
    
    @IBAction func likeButtonAction(_ sender: Any) {
        likeButtonTitle.likedAction()
    }
}
