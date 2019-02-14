//
//  HLPhotoItem.swift
//  PHPhotoDemo
//
//  Created by yunfu on 2019/2/14.
//  Copyright © 2019 yuhongli. All rights reserved.
//

import UIKit
import Photos

class HLPhotoItem: NSObject {

    private let asset:PHAsset
    init(_ item:PHAsset) {
        asset = item
        super.init()
    }
    
    open func asyGetImage(_ progress: HLProgress?=nil,_ resultHandler: @escaping (UIImage?, [AnyHashable : Any]?) -> Void)  {
        HLPhotoManager.default().asyGetImage(asset, progress, resultHandler)
    }
    
    open func asyGetCachingImage(_ targetSize:CGSize,_ resultHandler: @escaping (UIImage?, [AnyHashable : Any]?) -> Void)  {
        HLPhotoManager.default().asyGetCachingImage(asset, targetSize, resultHandler)
    }
    
}
