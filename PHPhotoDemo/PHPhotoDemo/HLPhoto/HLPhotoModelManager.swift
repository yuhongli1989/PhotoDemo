//
//  HLPhotoModel.swift
//  PHPhotoDemo
//
//  Created by yunfu on 2019/2/13.
//  Copyright © 2019 yuhongli. All rights reserved.
//

import UIKit
import Photos

class HLPhotoModelManager {
    
    private let result:PHFetchResult<PHAsset>
    
    var count:Int{
        return result.count
    }
    
    init(_ m:PHFetchResult<PHAsset>) {
        
        result = m
    }
    
    func asyGetCachImage(_ index:Int,_ targetSize:CGSize,_ resultHandler: @escaping (UIImage?, [AnyHashable : Any]?) -> Void)  {
        guard let asset = getAsset(index) else {
            return
        }
        HLPhotoManager.default().asyGetCachingImage(asset, targetSize, resultHandler)
        
    }
    
    func asyGetImage(_ index:Int,_ progress: HLProgress?=nil,_ resultHandler: @escaping (UIImage?, [AnyHashable : Any]?) -> Void)  {
        guard let asset = getAsset(index) else {
            return
        }
        HLPhotoManager.default().asyGetImage(asset, progress, resultHandler)
    }
    
    private func getAsset(_ index:Int)->PHAsset?{
        guard index>=0 && index<count else {
            return nil
        }
        return result.object(at: index)
    }
    
    //获取标识符
    func getLocalIdentifier(_ index:Int) -> String? {
        guard let asset = getAsset(index) else {
            return nil
        }
        return asset.localIdentifier
    }
    
}
