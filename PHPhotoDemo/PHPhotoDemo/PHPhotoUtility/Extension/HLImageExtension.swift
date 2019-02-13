//
//  HLImageExtension.swift
//  PHPhotoDemo
//
//  Created by yunfu on 2019/1/28.
//  Copyright © 2019 yuhongli. All rights reserved.
//

import UIKit
import Photos

extension UIImageView{
    
    typealias HLProgress = ((_ pro:Double,_ error:Error?)->Void)
    typealias HLCompletion = (()->Void)
    func hl_getStaticImage(_ photoAsset:PHAsset,_ progress: HLProgress?=nil,_ completion:HLCompletion?=nil)  {
        let options = PHImageRequestOptions()
        options.isNetworkAccessAllowed = true
        options.deliveryMode = .highQualityFormat
        options.progressHandler = { pro,error,_,info in
            progress?(pro,error)
        }
        
        PHImageManager.default().requestImage(for: photoAsset, targetSize: self.bounds.size, contentMode: .aspectFit, options: options) {[weak self] (image, _) in
            self?.image = image
            completion?()
        }
    }
    
}
