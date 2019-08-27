//
//  MagicMoveCell.swift
//  DTSMagicMove
//
//  Created by yantommy on 2016/11/24.
//  Copyright © 2016年 yantommy. All rights reserved.
//

import UIKit

class MagicMoveCell: UICollectionViewCell {

    @IBOutlet weak var magicContainer: UIView!
    @IBOutlet weak var albumImageView: UIImageView!
    @IBOutlet weak var albumTitleLabel: UILabel!
    @IBOutlet weak var albumTitleDetail: UILabel!
    
    @IBOutlet weak var watermarkView: UIView!
    
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        

        
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        //设置不裁剪，否则没有阴影
        self.clipsToBounds = false
        
        self.layer.shadowOpacity = 0.2
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 2)
        self.layer.shadowRadius = 4

        
        magicContainer.backgroundColor = UIColor.green
        magicContainer.clipsToBounds = true
        magicContainer.layer.cornerRadius = 3
        
    }

}
