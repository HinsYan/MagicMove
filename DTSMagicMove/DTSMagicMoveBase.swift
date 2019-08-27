//
//  DTSMagicMoveBase.swift
//  DTSMagicMove
//
//  Created by yantommy on 2016/11/24.
//  Copyright © 2016年 yantommy. All rights reserved.
//

import UIKit

class DTSMagicMoveBase: NSObject {
    
    var context: UIViewControllerContextTransitioning!
    var containerView: UIView!
    
    var fromVC: UIViewController!
    var toVC: UIViewController!
    
    var fromView: UIView!
    var toView: UIView!

    var magicItemFromView: UIView!
    var magicItemToView: UIView!
    
    var magicItemFromFrame: CGRect!
    var magicItemToFrame: CGRect!
    
    var magicMoveType: DTSMagicMoveType!

    var magicMoveDuration: TimeInterval = 5
    var magicMoveDampingRatio: CGFloat = 1.0
}

enum DTSMagicMoveType {
    
    case Goto
    case Back
}

extension DTSMagicMoveBase: UIViewControllerAnimatedTransitioning {

    public func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        
        return 5
    }
    
    public func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        self.context = transitionContext
        self.containerView = transitionContext.containerView
        self.fromVC = transitionContext.viewController(forKey: .from)
        self.toVC = transitionContext.viewController(forKey: .to)
        self.fromView = transitionContext.view(forKey: .from)
        self.toView = transitionContext.view(forKey: .to)
        
        print("-------------")
        print(fromView.frame)
        
        print(magicItemFromView.frame)
        print(magicItemToView.frame)
        
        //确定位置
        if self.magicItemFromView.superview != nil {
        
            self.magicItemFromFrame = (self.magicItemFromView.superview?.convert(self.magicItemFromView.frame, to: self.containerView))!

        }else{
        
            self.magicItemFromFrame = self.magicItemFromView.bounds
        }
        
        if self.magicItemToView.superview != nil {
        
            
            self.magicItemToFrame = (self.magicItemToView.superview?.convert(self.magicItemToView.frame, to: self.containerView))!


        }else{
        
            self.magicItemToFrame = self.magicItemToView.bounds


        }
        
        print("确定类型")
        //确定类型
        if self.magicMoveType == DTSMagicMoveType.Goto {
        
            self.animationGoto()

        }else{
        
            self.animationBack()
        }

        
    }
    
    
    public func animationEnded(_ transitionCompleted: Bool) {
        
        
    }
    
    public func captureImageFromLayer(Layer: CALayer,isOpaque: Bool) -> UIImageView {
    
        
        UIGraphicsBeginImageContextWithOptions(Layer.bounds.size, false, 0)
    
        Layer.render(in: UIGraphicsGetCurrentContext()!)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFill
        
        imageView.clipsToBounds = true
        
        return imageView
    }
    
    func animationGoto() {
        
        
    }
    
    func animationBack() {
    
        
    }
}

