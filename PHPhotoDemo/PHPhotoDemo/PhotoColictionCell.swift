//
//  PhotoColictionCell.swift
//  PHPhotoDemo
//
//  Created by 于洪礼 on 2019/1/27.
//  Copyright © 2019 yuhongli. All rights reserved.
//

import UIKit

class PhotoColictionCell: UITableViewCell {
    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    var localIdentifier = ""
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    static public var cellIdentifier: String{
        
        return "PhotoColictionCell"
    }
    
}
