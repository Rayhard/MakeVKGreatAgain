//
//  AllFriendsImagesController.swift
//  MakeVKGreatAgain
//
//  Created by n.perezhogin on 26.02.2020.
//  Copyright © 2020 n.perezhogin. All rights reserved.
//

import UIKit

class AllFriendsImagesController: UIViewController {
    var friendImagesArray: [UIImage] = []
    var focusImage = 0
    
    @IBOutlet weak var friendImageView: FullScreenImageView!
    
    @IBOutlet weak var likeButtonTitle: LikeButton!
    @IBAction func likeButton(_ sender: Any) {
        likeButtonTitle.likedAction()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        friendImageView.image = friendImagesArray[0]
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.rightSwipeAnimation), name: NSNotification.Name(rawValue: "imageRightSwipe"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.leftSwipeAnimation), name: NSNotification.Name(rawValue: "imageLeftSwipe"), object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "imageRightSwipe"), object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "imageLeftSwipe"), object: nil)
    }
    
    @objc func leftSwipeAnimation(){
        guard (focusImage >= 0) && (focusImage < friendImagesArray.count - 1) else { return }
        let tmpImage = newImageView(1000)
        self.view.addSubview(tmpImage)
        UIView.animate(withDuration: 0.5,
                       animations: {
                        tmpImage.frame.origin.x = 0
        }) { _ in
            self.focusImage += 1
            self.friendImageView.image = self.friendImagesArray[self.focusImage]
            tmpImage.removeFromSuperview()
        }
        
    }
    @objc func rightSwipeAnimation(){
        guard (focusImage >= 1) && (focusImage <= friendImagesArray.count) else { return }
        let tmpImage = newImageView(-500)
        self.view.addSubview(tmpImage)
        UIView.animate(withDuration: 0.5,
                       animations: {
                        tmpImage.frame.origin.x = 0
        }) { _ in
            self.focusImage -= 1
            self.friendImageView.image = self.friendImagesArray[self.focusImage]
            tmpImage.removeFromSuperview()
        }
    }
    
    private func newImageView(_ xToMove: CGFloat) -> UIImageView{
        let tmpImage = UIImageView()
        tmpImage.frame = CGRect(x: xToMove, y: friendImageView.frame.minY, width: friendImageView.frame.width, height: friendImageView.frame.height)
        if xToMove > 0{
            tmpImage.image = friendImagesArray[focusImage + 1]
        } else {
            tmpImage.image = friendImagesArray[focusImage - 1]
        }
        tmpImage.contentMode = .scaleAspectFit
        return tmpImage
    }

}
