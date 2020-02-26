//
//  FullScreenImageView.swift
//  MakeVKGreatAgain
//
//  Created by n.perezhogin on 26.02.2020.
//  Copyright © 2020 n.perezhogin. All rights reserved.
//

import UIKit

class FullScreenImageView: UIImageView {
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let swipeLeftGesture = UISwipeGestureRecognizer(target: self, action: #selector(onTap(_:)))
        swipeLeftGesture.direction = .left
        let swipeRightGesture = UISwipeGestureRecognizer(target: self, action: #selector(onTap(_:)))
        swipeRightGesture.direction = .right
        
        self.addGestureRecognizer(swipeLeftGesture)
        self.addGestureRecognizer(swipeRightGesture)
        self.isUserInteractionEnabled = true
    }
    
    @objc func onTap(_ sender: UIGestureRecognizer) {
        let leftAnimationGroup = CAAnimationGroup()
        leftAnimationGroup.duration = 0.5
        leftAnimationGroup.fillMode = CAMediaTimingFillMode.backwards

        let rightAnimationGroup = CAAnimationGroup()
        rightAnimationGroup.duration = 0.5
        rightAnimationGroup.fillMode = CAMediaTimingFillMode.backwards

        let reductionAnimation = CASpringAnimation(keyPath: "transform.scale")
        reductionAnimation.toValue = 0.4

        leftAnimationGroup.animations = [reductionAnimation]
        rightAnimationGroup.animations = [reductionAnimation]

        if let swipeGesture = sender as? UISwipeGestureRecognizer {
            switch swipeGesture.direction {
            case .right:
                self.layer.add(rightAnimationGroup, forKey: nil)
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "imageRightSwipe"), object: nil)
            case .left:
                self.layer.add(leftAnimationGroup, forKey: nil)
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "imageLeftSwipe"), object: nil)
            default:
                break
            }
        }
    }

}
