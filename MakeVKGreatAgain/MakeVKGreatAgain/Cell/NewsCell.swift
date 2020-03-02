//
//  NewsCell.swift
//  MakeVKGreatAgain
//
//  Created by n.perezhogin on 19.02.2020.
//  Copyright © 2020 n.perezhogin. All rights reserved.
//

import UIKit

class NewsCell: UITableViewCell{
    
    @IBOutlet weak var authorImage: UIImageView!
    @IBOutlet weak var authorName: UILabel!
    
    @IBOutlet weak var contentText: UITextView!
    @IBOutlet weak var contentImage: UIImageView!
    @IBOutlet weak var likeButtonCount: LikeButton!
    
    @IBOutlet weak var contentImageHeight: NSLayoutConstraint!
    
    @IBAction func likeButton(_ sender: Any) {
        likeButtonCount.likedAction()
    }
}
