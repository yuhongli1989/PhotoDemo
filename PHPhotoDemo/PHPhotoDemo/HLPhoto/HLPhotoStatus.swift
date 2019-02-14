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
    
    public init(_ isSuccess:@escaping (_ isOk:Bool)->()) {
        super.init()
        
        PHPhotoLibrary.requestAuthorization { (status) in
            let isok:Bool
            switch status{
            case .authorized://授权访问
                isok = true
                break
            case .denied,.notDetermined,.restricted://用户拒绝访问 没有授权 无权访问，用户无法授权
                isok = false
                break
            }
            DispatchQueue.main.async {
                isSuccess(isok)
            }
        }
        
        
    }

}






