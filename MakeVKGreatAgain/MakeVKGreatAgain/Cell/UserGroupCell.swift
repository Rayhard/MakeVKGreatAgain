//
//  UserGroupCell.swift
//  MakeVKGreatAgain
//
//  Created by n.perezhogin on 09.02.2020.
//  Copyright © 2020 n.perezhogin. All rights reserved.
//

import UIKit

class UserGroupCell: UITableViewCell {
    @IBOutlet weak var userGroupImage: UIImageView!
    @IBOutlet weak var userGroupName: UILabel!
    
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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(onTap(_:)))
        
        userGroupImage.addGestureRecognizer(tapGesture)
        userGroupImage.isUserInteractionEnabled = true
        
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
        self.containerView.layer.add(animation, forKey: nil)
        self.shadowView.layer.add(animation, forKey: nil)
    }
}
