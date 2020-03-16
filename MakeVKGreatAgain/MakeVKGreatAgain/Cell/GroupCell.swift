//
//  GroupCell.swift
//  MakeVKGreatAgain
//
//  Created by n.perezhogin on 16.03.2020.
//  Copyright © 2020 n.perezhogin. All rights reserved.
//

import UIKit

class GroupCell: UITableViewCell {

    @IBOutlet weak var shadowView: ShadowView!
    @IBOutlet weak var groupImage: UIImageView!{
        didSet {
            self.groupImage.clipsToBounds = true
        }
    }
    @IBOutlet weak var groupName: UILabel!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.shadowView.layer.shadowPath = UIBezierPath(ovalIn: self.shadowView.bounds).cgPath
        self.shadowView.layer.cornerRadius = self.shadowView.frame.width / 2
        self.groupImage.layer.cornerRadius = self.groupImage.frame.width / 2
    }

}
