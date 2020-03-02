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
    
//    override func draw(_ rect: CGRect) {
//        super.draw(rect)
//        guard let context = UIGraphicsGetCurrentContext() else { return }
//        context.setStrokeColor(UIColor.red.cgColor)
//        let bezierPath = UIBezierPath()
//        bezierPath.move(to: CGPoint(x: 46, y: 34))
//        bezierPath.addLine(to: CGPoint(x: 17, y: 34))
//        bezierPath.addCurve(to: CGPoint(x: 0, y: 17), controlPoint1: CGPoint(x: 7.61, y: 34), controlPoint2: CGPoint(x: 0, y: 26.39))
//        bezierPath.addCurve(to: CGPoint(x: 17, y: 0), controlPoint1: CGPoint(x: 0, y: 7.61), controlPoint2: CGPoint(x: 7.61, y: 0))
//        bezierPath.addLine(to: CGPoint(x: 47, y: 0))
//        bezierPath.addCurve(to: CGPoint(x: 64, y: 17), controlPoint1: CGPoint(x: 56.39, y: 0), controlPoint2: CGPoint(x: 64, y: 7.61))
//        bezierPath.addLine(to: CGPoint(x: 64, y: 23))
//        bezierPath.addCurve(to: CGPoint(x: 68, y: 34), controlPoint1: CGPoint(x: 64, y: 33), controlPoint2: CGPoint(x: 68, y: 34))
//        bezierPath.addLine(to: CGPoint(x: 68.05, y: 33.99))
//        bezierPath.addCurve(to: CGPoint(x: 56.96, y: 29.96), controlPoint1: CGPoint(x: 63.93, y: 34.43), controlPoint2: CGPoint(x: 59.84, y: 32.94))
//        bezierPath.addCurve(to: CGPoint(x: 46, y: 34), controlPoint1: CGPoint(x: 52, y: 34), controlPoint2: CGPoint(x: 49, y: 34))
//        bezierPath.close()
//        bezierPath.stroke()
//    }

}
