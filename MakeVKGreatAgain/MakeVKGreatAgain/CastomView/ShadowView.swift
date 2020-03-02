//
//  ShadowView.swift
//  MakeVKGreatAgain
//
//  Created by n.perezhogin on 13.02.2020.
//  Copyright © 2020 n.perezhogin. All rights reserved.
//

import UIKit

class ShadowView: UIView {
    
    @IBInspectable var shadowOffset: CGSize = .zero{
        didSet{
            self.updateShadowOffset()
        }
    }
    @IBInspectable var shadowOpacity: Float = 0.75{
        didSet{
            self.updateShadowOpacity()
        }
    }
    @IBInspectable var shadowRadius: CGFloat = 6{
        didSet{
            self.updateShadowRadius()
        }
    }
    
    func updateShadowOffset(){
        self.layer.shadowOffset = shadowOffset
    }
    func updateShadowOpacity(){
        self.layer.shadowOpacity = shadowOpacity
    }
    func updateShadowRadius(){
        self.layer.shadowRadius = shadowRadius
    }

}
