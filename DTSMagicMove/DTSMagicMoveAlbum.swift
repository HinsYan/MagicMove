//
//  DTSMagicMoveAlbum.swift
//  DTSMagicMove
//
//  Created by yantommy on 2016/11/25.
//  Copyright © 2016年 yantommy. All rights reserved.
//

import UIKit

class DTSMagicMoveAlbum: DTSMagicMoveBase {

    var magicItemCaptureFromView: UIImageView!
    var magicItemCaptureToView: UIImageView!
    
    var albumContainerView: UIView!
    
    
}


extension DTSMagicMoveAlbum {

    override func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        super.animateTransition(using: transitionContext)
        
        
    }
    
    override func animationGoto() {
        
        //优先裁剪，再设置fromView和toView的透明度
        self.magicItemCaptureFromView = self.captureImageFromLayer(Layer: self.magicItemFromView.layer, isOpaque: false)
        self.magicItemCaptureToView = self.captureImageFromLayer(Layer: self.magicItemToView.layer, isOpaque: false)
        
        //toView可能和magicItemFromView是同一个对象，所以优先设置magicItemFromView保证不会被覆盖
        self.magicItemFromView.alpha = 0.0
        self.magicItemToView.alpha = 0.0
        
        fromView.alpha = 1.0
        toView.alpha = 0.0
        
        //预处理
        self.magicItemCaptureFromView.alpha = 1.0
        self.magicItemCaptureToView.alpha = 0.0
        
        self.magicItemCaptureFromView.frame = magicItemFromFrame
        self.magicItemCaptureToView.frame = magicItemCaptureFromView.frame
        
        //注意层级关系
        containerView.addSubview(self.toView)
        containerView.addSubview(self.fromView)
        
        self.containerView.addSubview(magicItemCaptureToView)
        self.containerView.addSubview(magicItemCaptureFromView)
        
        
        UIView.animate(withDuration: transitionDuration(using: context), delay: 0, usingSpringWithDamping: magicMoveDampingRatio, initialSpringVelocity: 0.5, options: [.curveEaseOut], animations: {
            
            
            self.magicItemCaptureFromView.frame = self.magicItemToFrame
            self.magicItemCaptureToView.frame = self.magicItemCaptureFromView.frame
            
            self.magicItemCaptureFromView.alpha = 0.0
            self.magicItemCaptureToView.alpha = 1.0
            
            self.fromView.alpha = 0.0
            
            
            if self.magicItemToView.bounds == UIScreen.main.bounds {
                
                print("全屏幕")
                self.toView.alpha = 0.0
                
            }else{
                
                // MARK: - Todo 在toView为充满整个屏幕的View时应该设置alpha为0.0 这里为了方便，统一处理为1.0
                self.toView.alpha = 1.0
                
            }
            
            
        }, completion: { (success) in
            
            self.magicItemFromView.alpha = 1.0
            self.magicItemToView.alpha = 1.0
            
            self.magicItemCaptureToView.removeFromSuperview()
            self.magicItemCaptureFromView.removeFromSuperview()
            
            
            self.context.completeTransition(!self.context.transitionWasCancelled)
            
        })
        


        
    }
    
    override func animationBack() {
        
        
    }
}
