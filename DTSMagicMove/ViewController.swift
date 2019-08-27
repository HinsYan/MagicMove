//
//  ViewController.swift
//  DTSMagicMove
//
//  Created by yantommy on 2016/11/24.
//  Copyright © 2016年 yantommy. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var collectionView1: UICollectionView!
    @IBOutlet weak var collectionView2: UICollectionView!
    
    var magicMoveTransition = DTSMagicMoveGeneral()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView1.delegate = self
        collectionView1.dataSource = self

        collectionView2.delegate = self
        collectionView2.dataSource = self
        

        collectionView2.register(UINib.init(nibName: "MagicMoveCell", bundle: Bundle.main),forCellWithReuseIdentifier: "MagicMoveCell")
        collectionView1.register(UINib.init(nibName: "MagicMoveCell", bundle: Bundle.main),forCellWithReuseIdentifier: "MagicMoveCell")

        self.automaticallyAdjustsScrollViewInsets = false
        
        collectionView2.clipsToBounds = false
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

extension ViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView == collectionView1 {
        
            return 8

        }else{
        
        
            return 6
        }
        
             
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == collectionView1 {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MagicMoveCell", for: indexPath) as! MagicMoveCell
            
            return cell
            
            
        }else{
        
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MagicMoveCell", for: indexPath) as! MagicMoveCell
            
            return cell
        }
    
    }
}

extension ViewController: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if collectionView == collectionView1 {
        
            print("Collection1\(indexPath.row)")
            
            let toVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CollectionVC") as! CollectionVC
            
            magicMoveTransition.magicItemFromView = collectionView.cellForItem(at: indexPath)
            //将view和视图加进内存，方便获取确定位置，也顺便刷新约束和位置
            toVC.view.layoutIfNeeded()
            magicMoveTransition.magicItemToView = toVC.imageView
        
            
            self.navigationController?.delegate = self
            self.navigationController?.pushViewController(toVC, animated: true)

            
        }else{
        
            print("Collection2\(indexPath.row)")
            
            let toVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AlbumVC") as! AlbumVC
            
            magicMoveTransition.magicItemFromView = collectionView.cellForItem(at: indexPath)
            //将view和视图加进内存，方便获取确定位置，也顺便刷新约束和位置
            toVC.view.layoutIfNeeded()
            magicMoveTransition.magicItemToView = toVC.view

            toVC.transitioningDelegate = self
            present(toVC, animated: true, completion: nil)
            

        }
        
    }
    
}

extension ViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if collectionView == collectionView1 {
        
            
            return CGSize(width: (collectionView.bounds.size.width-60)/2, height: (collectionView.bounds.size.width-60)/2)
            
        }else{
        
            return CGSize(width: collectionView.bounds.height*4/7, height: collectionView.bounds.height)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        if collectionView == collectionView1 {
        
            return UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20)

        }else{
        
            return UIEdgeInsets(top: 6, left: 10, bottom: 0, right: 0.0)
            
        }
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        if collectionView == collectionView1 {
            
            return 20
            
        }else{
            
            return 3
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        
        if collectionView == collectionView1 {
            
            return 20
            
        }else{
            
            return 0
        }
    }
}

extension ViewController: UINavigationControllerDelegate {


    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        if operation == .push {
        
            magicMoveTransition.magicMoveType = DTSMagicMoveType.Goto
            
        }else{
        
            magicMoveTransition.magicMoveType = DTSMagicMoveType.Back
            
        }
        
        return magicMoveTransition
    }
    
    
}

extension ViewController: UIViewControllerTransitioningDelegate {

    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        magicMoveTransition.magicMoveType = DTSMagicMoveType.Goto
        magicMoveTransition.magicMoveDampingRatio = 0.6
        
        return magicMoveTransition
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        magicMoveTransition.magicMoveType = DTSMagicMoveType.Back

        return magicMoveTransition
    }
}

