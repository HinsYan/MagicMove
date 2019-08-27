//
//  DTSMagicMove.swift
//  DTSMagicMove
//
//  Created by yantommy on 2016/11/24.
//  Copyright © 2016年 yantommy. All rights reserved.
//

import UIKit

class DTSMagicMoveGeneral: DTSMagicMoveBase {

    var magicItemCaptureFromView: UIImageView!
    var magicItemCaptureToView: UIImageView!
    
    var magicWidthRatioFromFrame: CGFloat!
    var magicHeightRatioFromFrame: CGFloat!
    
    var magicXOffsetFromFrame: CGFloat!
    var magicYOffsetFromFrame: CGFloat!
    
    
    var magicWidthRatioToFrame: CGFloat!
    var magicHeightRatioToFrame: CGFloat!
    
    var magicXOffsetToFrame: CGFloat!
    var magicYOffsetToFrame: CGFloat!
    
    var general = true
    
    
    func animationGotoGeneral(){
    
        if general {
            
        //计算
        self.magicWidthRatioFromFrame = self.magicItemToFrame.size.width/self.magicItemFromFrame.size.width
        self.magicHeightRatioFromFrame = self.magicItemToFrame.size.height/self.magicItemFromFrame.size.height
        
        //fromItem位移
        self.magicXOffsetFromFrame = (self.magicItemToFrame.origin.x - self.magicItemFromFrame.origin.x) + ((self.magicWidthRatioFromFrame - 1) * self.magicItemFromFrame.size.width)
        self.magicYOffsetFromFrame = (self.magicItemToFrame.origin.y - self.magicItemFromFrame.origin.y) + ((self.magicHeightRatioFromFrame - 1) * self.magicItemFromFrame.size.height)
            
            
        self.magicWidthRatioToFrame = self.magicItemFromFrame.size.width/self.magicItemToFrame.size.width
        self.magicHeightRatioToFrame = self.magicItemFromFrame.size.height/self.magicItemToFrame.size.height
        
        self.magicXOffsetToFrame = (self.magicItemFromFrame.origin.x - abs((self.magicWidthRatioToFrame - 1) * self.magicItemToFrame.size.width/2))
        self.magicYOffsetToFrame = (self.magicItemFromFrame.origin.y - self.magicItemToFrame.origin.y) + ((self.magicHeightRatioToFrame - 1) * self.magicItemToFrame.size.height)
         
                            

            print("X偏移")
            print(self.magicXOffsetToFrame)
            
            //预处理
            
            self.fromView.transform = CGAffineTransform.identity
            self.toView.transform = CGAffineTransform(a: self.magicWidthRatioToFrame, b: 0, c: 0, d: self.magicHeightRatioToFrame, tx: self.magicXOffsetToFrame, ty: self.magicYOffsetToFrame)
            
            print("开始Follow动画")

        }
        
        
        UIView.animate(withDuration: transitionDuration(using: context), delay: 0, usingSpringWithDamping: magicMoveDampingRatio, initialSpringVelocity: 0.5, options: [.curveEaseOut], animations: {
            
            
            self.magicItemCaptureFromView.frame = self.magicItemToFrame
            self.magicItemCaptureToView.frame = self.magicItemCaptureFromView.frame
            
            self.magicItemCaptureFromView.alpha = 0.0
            self.magicItemCaptureToView.alpha = 1.0
            
            self.fromView.alpha = 0.0
            
            
            if self.general {
             
                
                self.fromView.transform = CGAffineTransform(a: self.magicWidthRatioFromFrame, b: 0, c: 0, d: self.magicHeightRatioFromFrame, tx: self.magicXOffsetFromFrame, ty: self.magicYOffsetFromFrame)
                self.toView.transform = CGAffineTransform.identity
                

            }
            
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
            
            if self.general {
            
                self.fromView.transform = CGAffineTransform.identity
                self.toView.transform = CGAffineTransform.identity
            }
            
            self.context.completeTransition(!self.context.transitionWasCancelled)
            
        })
        
        
    }
    
    func animationBackGeneral(){
    
        
        
        
        UIView.animate(withDuration: transitionDuration(using: context), delay: 0, usingSpringWithDamping: magicMoveDampingRatio, initialSpringVelocity: 1.0, options: [.curveEaseOut], animations: {
            
            self.magicItemCaptureToView.frame = self.magicItemFromFrame
            self.magicItemCaptureFromView.frame = self.magicItemCaptureToView.frame
            
            
            self.magicItemCaptureFromView.alpha = 1.0
            self.magicItemCaptureToView.alpha = 0.0
            
            self.fromView.alpha = 0.0
            self.toView.alpha = 1.0
            
            
        }, completion: { (success) in
            
            self.magicItemFromView.alpha = 1.0
            self.magicItemToView.alpha = 1.0
            
            self.magicItemCaptureToView.removeFromSuperview()
            self.magicItemCaptureFromView.removeFromSuperview()
            
            self.context.completeTransition(!self.context.transitionWasCancelled)
            
        })
        

        
    }
}

extension DTSMagicMoveGeneral {

    
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

        
        print("animationGoto完毕")
        //开始动画
        self.animationGotoGeneral()
        
        
  
    }
    
    override func animationBack() {
        
        //优先裁剪，再设置fromView和toView的透明度
        self.magicItemCaptureFromView = self.captureImageFromLayer(Layer: self.magicItemFromView.layer, isOpaque: false)
        self.magicItemCaptureToView = self.captureImageFromLayer(Layer: self.magicItemToView.layer, isOpaque: false)
        
        
        fromView.alpha = 1.0
        toView.alpha = 0.0
        
        //fromView可能和magicItemToView是同一个对象，所以最后设置magicItemToView保证不会被覆盖
        self.magicItemFromView.alpha = 0.0
        self.magicItemToView.alpha = 0.0

        //预处理
        self.magicItemCaptureFromView.alpha = 0.0
        self.magicItemCaptureToView.alpha = 1.0
        
        self.magicItemCaptureToView.frame = magicItemToFrame
        self.magicItemCaptureFromView.frame = magicItemCaptureToView.frame
        
        //注意层级关系
        containerView.addSubview(self.toView)
        containerView.addSubview(self.fromView)


        self.containerView.addSubview(magicItemCaptureFromView)
        self.containerView.addSubview(magicItemCaptureToView)

        
        //开始动画
        self.animationBackGeneral()
        
        
    }
    
}
