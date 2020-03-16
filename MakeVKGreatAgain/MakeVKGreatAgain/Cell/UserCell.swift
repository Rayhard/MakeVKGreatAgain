//
//  UserCell.swift
//  MakeVKGreatAgain
//
//  Created by n.perezhogin on 16.03.2020.
//  Copyright © 2020 n.perezhogin. All rights reserved.
//

import UIKit

class UserCell: UITableViewCell {
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userImage: UIImageView!{
        didSet {
            self.userImage.clipsToBounds = true
        }
    }
    @IBOutlet weak var shadowView: ShadowView!
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.shadowView.layer.shadowPath = UIBezierPath(ovalIn: self.shadowView.bounds).cgPath
        self.shadowView.layer.cornerRadius = self.shadowView.frame.width / 2
        self.userImage.layer.cornerRadius = self.userImage.frame.width / 2
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(onTap(_:)))
        
        userImage.addGestureRecognizer(tapGesture)
        userImage.isUserInteractionEnabled = true
        
    }
    
    @objc func onTap(_ sender: UIGestureRecognizer) {
        let animation = CASpringAnimation(keyPath: "transform.scale")
        animation.fromValue = 0.9
        animation.toValue = 1
        animation.stiffness = 100
        animation.mass = 2
        animation.duration = 0.3
        animation.beginTime = CACurrentMediaTime()
        animation.fillMode = CAMediaTimingFillMode.backwards
        self.userImage.layer.add(animation, forKey: nil)
        self.shadowView.layer.add(animation, forKey: nil)
    }
}
