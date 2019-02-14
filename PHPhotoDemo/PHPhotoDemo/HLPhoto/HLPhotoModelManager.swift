//
//  HLPhotoModel.swift
//  PHPhotoDemo
//
//  Created by yunfu on 2019/2/13.
//  Copyright © 2019 yuhongli. All rights reserved.
//

import UIKit
import Photos

class HLPhotoModelManager:NSObject {
    
    private var result:PHFetchResult<PHAsset>
    var photoChange:(()->())?
    var count:Int{
        return result.count
    }
    
    public init(_ m:PHFetchResult<PHAsset>) {
        result = m
        super.init()
        PHPhotoLibrary.shared().register(self)
    }
    
    deinit {
        PHPhotoLibrary.shared().unregisterChangeObserver(self)
    }
    
    open func asyGetCachImage(_ index:Int,_ targetSize:CGSize,_ resultHandler: @escaping (UIImage?, [AnyHashable : Any]?) -> Void)  {
        guard let asset = getAsset(index) else {
            return
        }
        HLPhotoManager.default().asyGetCachingImage(asset, targetSize, resultHandler)
        
    }
    
    open func asyGetImage(_ index:Int,_ progress: HLProgress?=nil,_ resultHandler: @escaping (UIImage?, [AnyHashable : Any]?) -> Void)  {
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
    open func getLocalIdentifier(_ index:Int) -> String? {
        guard let asset = getAsset(index) else {
            return nil
        }
        return asset.localIdentifier
    }
    
    open subscript(_ index:Int)->HLPhotoItem?{
        guard let asset = getAsset(index) else{return nil}
        return HLPhotoItem(asset)
    }
    
}
extension HLPhotoModelManager:PHPhotoLibraryChangeObserver{
    internal func photoLibraryDidChange(_ changeInstance: PHChange) {
        if let changeDetails = changeInstance.changeDetails(for: result){
            result = changeDetails.fetchResultAfterChanges
            photoChange?()
        }
    }
    
}

