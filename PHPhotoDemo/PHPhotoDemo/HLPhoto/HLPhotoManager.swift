//
//  HLPhotoManager.swift
//  PHPhotoDemo
//
//  Created by yunfu on 2019/2/13.
//  Copyright © 2019 yuhongli. All rights reserved.
//

import UIKit
import Photos

typealias HLProgress = ((_ pro:Double,_ error:Error?)->Void)

class HLPhotoManager: NSObject {
    
    private let cachingManager = PHCachingImageManager()
    static func `default`() -> HLPhotoManager{
        return HLPhotoManager()
    }
    //获取所有缓存图片
    func getAllCachingImages()->HLPhotoModelManager{
        let options = PHFetchOptions()
        options.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: true)]
        let fetchResult = PHAsset.fetchAssets(with: options)
        return HLPhotoModelManager(fetchResult)
    }
    //获取图片所有分类
    func getAllCollections() ->[HLCollectionManager] {
        let options = PHFetchOptions()
        var result = [HLCollectionManager]()
        let collectionItems = PHAssetCollection.fetchAssetCollections(with: .smartAlbum, subtype: .any, options: options)
        collectionItems.enumerateObjects({ (collection, i, _) in
            
            let assets = PHAsset.fetchAssets(in: collection, options: nil)
            if assets.count <= 0{
                return
            }
            let model = HLCollectionManager(collection)
            if collection.assetCollectionSubtype == .smartAlbumUserLibrary{
                result.insert(model, at: 0)
            }else{
                result.append(model)
            }
        })
        
        return result
    }
    
    ///获取缓存图片
    func asyGetCachingImage(_ asset:PHAsset,_ targetSize:CGSize,_ resultHandler: @escaping (UIImage?, [AnyHashable : Any]?) -> Void)  {
        cachingManager.requestImage(for: asset, targetSize: targetSize, contentMode: .aspectFill, options: nil,resultHandler: resultHandler)
    }
    ///获取原图片
    func asyGetImage(_ asset:PHAsset,_ progress: HLProgress?=nil,_ resultHandler: @escaping (UIImage?, [AnyHashable : Any]?) -> Void)  {

        let options = PHImageRequestOptions()
        options.isNetworkAccessAllowed = true
        options.deliveryMode = .highQualityFormat
        options.progressHandler = { pro,error,_,info in
            progress?(pro,error)
        }
        
        PHImageManager.default().requestImage(for: asset, targetSize: UIScreen.main.bounds.size, contentMode: .aspectFit, options: options,resultHandler: resultHandler)
    }
    
}
