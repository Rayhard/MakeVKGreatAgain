//
//  FullScreenImageView.swift
//  MakeVKGreatAgain
//
//  Created by n.perezhogin on 26.02.2020.
//  Copyright © 2020 n.perezhogin. All rights reserved.
//

import UIKit
import Kingfisher

class FullScreenImageView: UIImageView {
    var imageArray: [Photo] = []
    var focusImage = 0
    
    let cache = ImageCache.default
    
    private enum Direction{
        case left, right
    }
    
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

        if let swipeGesture = sender as? UISwipeGestureRecognizer {
            switch swipeGesture.direction {
            case .right:
                guard (focusImage >= 1) && (focusImage <= imageArray.count) else { return }
                
                let tmpImage = newImageView(self.frame.minX, direction: .right)
                superview?.addSubview(tmpImage)
                self.transform = CGAffineTransform(scaleX: 0.25, y: 0.25)
                self.focusImage -= 1
                
                self.getImage(sourceImage: self, focus: self.focusImage)
                
                //self.image = self.imageArray[self.focusImage]
                
                UIView.animateKeyframes(withDuration: 1,
                                        delay: 0,
                                        options: [],
                                        animations: {
                                            UIView.addKeyframe(withRelativeStartTime: 0.0,
                                                               relativeDuration: 0.5) {
                                                                tmpImage.center.x += self.center.x * 2
                                            }
                                            UIView.addKeyframe(withRelativeStartTime: 0.0,
                                                               relativeDuration: 0.5) {
                                                                self.transform = CGAffineTransform(scaleX: 1, y: 1)
                                            }
                }) { _ in
                    tmpImage.removeFromSuperview()
                }
            case .left:
                guard (focusImage >= 0) && (focusImage < imageArray.count - 1) else { return }
                
                let tmpImage = newImageView(self.frame.maxX, direction: .left)
                superview?.addSubview(tmpImage)
                
                UIView.animateKeyframes(withDuration: 1,
                                        delay: 0,
                                        options: [],
                                        animations: {
                                            UIView.addKeyframe(withRelativeStartTime: 0.0,
                                                               relativeDuration: 0.5) {
                                                                self.transform = CGAffineTransform(scaleX: 0.25, y: 0.25)
                                            }
                                            UIView.addKeyframe(withRelativeStartTime: 0.0,
                                                               relativeDuration: 0.5) {
                                                                tmpImage.center.x = self.center.x
                                            }
                }) { _ in
                    self.focusImage += 1
                    
                    self.getImage(sourceImage: self, focus: self.focusImage)
                    
                    //self.image = self.imageArray[self.focusImage]
                    self.transform = CGAffineTransform(scaleX: 1, y: 1)
                    tmpImage.removeFromSuperview()
                }
            default:
                break
            }
        }
    }
    
    private func newImageView(_ tmpX: CGFloat, direction: Direction) -> UIImageView{
        let tmpImage = UIImageView()
        if direction == .left{
            getImage(sourceImage: tmpImage, focus: focusImage + 1)
            
            //tmpImage.image = imageArray[focusImage + 1]
            tmpImage.frame = CGRect(x: tmpX, y: self.frame.minY, width: self.frame.width, height: self.frame.height)
        } else {
            getImage(sourceImage: tmpImage, focus: focusImage)
            //tmpImage.image = imageArray[focusImage]
            tmpImage.frame = CGRect(x: tmpX, y: self.frame.minY, width: self.frame.width, height: self.frame.height)
        }
        tmpImage.contentMode = .scaleAspectFit
        return tmpImage
    }
    
    private func getImage(sourceImage: UIImageView, focus: Int){
        cache.retrieveImage(forKey: self.imageArray[focus].imageUrl) { result in
            switch result {
            case .success(let value):
                sourceImage.image = value.image

            case .failure(let error):
                print(error)
            }
        }
    }

}
