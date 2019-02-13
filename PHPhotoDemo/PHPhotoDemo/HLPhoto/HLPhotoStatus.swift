//
//  HLPhotoStatus.swift
//  PHPhotoDemo
//
//  Created by yunfu on 2019/2/13.
//  Copyright © 2019 yuhongli. All rights reserved.
//

import UIKit
import Photos

class HLPhotoStatus: NSObject {
//NSPhotoLibraryUsageDescription info 添加白名单
    override init() {
        super.init()
        PHPhotoLibrary.requestAuthorization { (status) in
            switch status{
            case .authorized://授权访问
                break
            case .denied://用户拒绝访问
                break
            case .notDetermined://没有授权
                break
            case .restricted://无权访问，用户无法授权
                break
            }
        }
    }
    
    
    
}
