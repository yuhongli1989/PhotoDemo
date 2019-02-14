//
//  HLCollectionModel.swift
//  PHPhotoDemo
//
//  Created by yunfu on 2019/2/13.
//  Copyright © 2019 yuhongli. All rights reserved.
//

import UIKit
import Photos

class HLCollectionManager :NSObject{
    let titleStr:String
    private let assetCollection:PHAssetCollection
//    weak var delegate
    init(_ collection:PHAssetCollection) {
        assetCollection = collection
        let assets = PHAsset.fetchAssets(in: collection, options: nil)
        titleStr = NSLocalizedString("\(collection.localizedTitle ?? "")", comment: "") + "(\(assets.count))"
        
    }
    
    
    
    open func asyIconImage(_ resultHandler: @escaping (UIImage?, [AnyHashable : Any]?) -> Void)  {
        
        if let firstImage = firstObject{
            let scale = UIScreen.main.scale
            HLPhotoManager.default().asyGetCachingImage(firstImage, CGSize(width: 64*scale, height: 64*scale), resultHandler)
        }
    }
    
    open var localIdentifier:String?{
        return firstObject?.localIdentifier
    }
    
    private var firstObject:PHAsset?{
        let assets = PHAsset.fetchAssets(in: assetCollection, options: nil)
        return assets.firstObject
    }
    //
    open func getPhotoModel()->HLPhotoModelManager  {
        let assets = PHAsset.fetchAssets(in: assetCollection, options: nil)
        return HLPhotoModelManager(assets)
    }
    
}



