//
//  LikeControl.swift
//  MakeVKGreatAgain
//
//  Created by n.perezhogin on 13.02.2020.
//  Copyright © 2020 n.perezhogin. All rights reserved.
//

import UIKit

class LikeButton: UIButton {
    private var isLikebl: Bool = false
    private var likeCount: Int = 0
    private let imageLiked: UIImage = UIImage(systemName: "heart.fill")!
    private let imageNotLiked: UIImage = UIImage(systemName: "heart")!
    
    func likedAction(){
        if isLikebl {
            guard likeCount > 0 else{
                return
            }
            self.setTitle("\(likeCount - 1)", for: .normal)
            self.setImage(UIImage(systemName: "heart"), for: .normal)
            self.likeCount -= 1
            self.isLikebl = false
        } else {
            self.setTitle("\(likeCount + 1)", for: .normal)
            self.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            self.likeCount += 1
            self.isLikebl = true
        }
    }
}
