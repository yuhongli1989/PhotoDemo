//
//  HLAlbumCell.swift
//  PHPhotoDemo
//
//  Created by 于洪礼 on 2019/1/27.
//  Copyright © 2019 yuhongli. All rights reserved.
//

import UIKit

class HLAlbumCell: UICollectionViewCell {
    
    lazy var iconImage:UIImageView = {
        let img = UIImageView(frame: .zero)
        img.layer.masksToBounds = true
        img.contentMode = .scaleAspectFill
        return img
    }()
    
    var burstIdentifier = ""
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(iconImage)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
