//
//  MessageController.swift
//  MakeVKGreatAgain
//
//  Created by n.perezhogin on 24.02.2020.
//  Copyright © 2020 n.perezhogin. All rights reserved.
//

import UIKit

class MessageController: UIViewController {

    @IBOutlet var loadingElements: [LoadingAnimateView]!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadAnimate(loadingElements)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func loadAnimate(_ loadViews: [LoadingAnimateView]){
        let animation = CABasicAnimation(keyPath: #keyPath(CALayer.opacity))
        animation.beginTime = CACurrentMediaTime() + 0.5
        animation.fromValue = 0.3
        animation.toValue = 1
        animation.duration = 1.0
        animation.repeatCount = .infinity
        animation.autoreverses = true
        loadViews[2].layer.add(animation, forKey: nil)
        animation.beginTime = CACurrentMediaTime() + 0.8
        loadViews[0].layer.add(animation, forKey: nil)
        animation.beginTime = CACurrentMediaTime() + 1.0
        loadViews[1].layer.add(animation, forKey: nil)
    }

}
