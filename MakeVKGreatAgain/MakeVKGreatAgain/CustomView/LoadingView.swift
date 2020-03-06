//
//  LoadingView.swift
//  MakeVKGreatAgain
//
//  Created by n.perezhogin on 24.02.2020.
//  Copyright © 2020 n.perezhogin. All rights reserved.
//

import UIKit

class LoadingAnimateView: UIView {
    @IBInspectable var cornerRadius: CGFloat = 5{
        didSet {
            self.updateCornerRadius()
        }
    }
    @IBInspectable var clipsBounds: Bool = true{
        didSet{
            self.updateClipsToBounds()
        }
    }
    
    private func updateCornerRadius(){
        self.layer.cornerRadius = cornerRadius
    }
    private func updateClipsToBounds(){
        self.clipsToBounds = clipsBounds
    }
}
