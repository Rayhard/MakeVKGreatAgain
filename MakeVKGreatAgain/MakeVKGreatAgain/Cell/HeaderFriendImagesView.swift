//
//  HeaderFriendImagesView.swift
//  MakeVKGreatAgain
//
//  Created by n.perezhogin on 02.03.2020.
//  Copyright © 2020 n.perezhogin. All rights reserved.
//

import UIKit

class HeaderFriendImagesView: UICollectionReusableView {
    @IBOutlet weak var friendName: UILabel!
    @IBOutlet weak var friendAvatarImage: UIImageView!
    
    @IBOutlet weak var containerView: UIView!{
        didSet {
            self.containerView.clipsToBounds = true
        }
    }
    @IBOutlet weak var shadowView: ShadowView!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.shadowView.layer.shadowPath = UIBezierPath(ovalIn: self.shadowView.bounds).cgPath
        self.shadowView.layer.cornerRadius = self.shadowView.frame.width / 2
        self.containerView.layer.cornerRadius = self.containerView.frame.width / 2
    }
}
