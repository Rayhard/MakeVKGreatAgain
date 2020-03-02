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
}
