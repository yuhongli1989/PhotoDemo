//
//  HLAssetViewController.swift
//  PHPhotoDemo
//
//  Created by 于洪礼 on 2019/1/27.
//  Copyright © 2019 yuhongli. All rights reserved.
//

import UIKit
import Photos

class HLAssetViewController: UIViewController {

    var photoAsset:PHAsset
    
    let imageManager = PHImageManager.default()
    
    
    
    lazy var scrollView:UIScrollView = {
        let v = UIScrollView(frame: view.bounds)
        v.maximumZoomScale = 3
        v.minimumZoomScale = 1.0
        v.delegate = self
        return v
    }()
    
    lazy var imageView:UIImageView = {
        let img = UIImageView(frame: view.bounds)
        img.contentMode = .scaleAspectFit
        img.image = smallImage
        return img
    }()
    
    var smallImage:UIImage?
    
    init(_ asset:PHAsset,_ image:UIImage? = nil) {
        photoAsset = asset
        smallImage = image
        super.init(nibName: nil, bundle: nil)
        PHPhotoLibrary.shared().register(self)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        PHPhotoLibrary.shared().unregisterChangeObserver(self)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        view.addSubview(scrollView)
        scrollView.addSubview(imageView)
        
//        if photoAsset.mediaSubtypes.contains(.photoLive) {
//
//        }else{
//
//        }

        imageView.hl_getStaticImage(photoAsset)
        // Do any additional setup after loading the view.
    }
    //MARK:加载视频
    func updateLivePhoto()  {
        let options = PHLivePhotoRequestOptions()
        options.deliveryMode = .highQualityFormat
        options.isNetworkAccessAllowed = true
        options.progressHandler = { progress,_,_,_ in
            print("progress===\(progress)")
            
        }
        PHImageManager.default().requestLivePhoto(for: photoAsset, targetSize: imageView.bounds.size, contentMode: .aspectFit, options: options) { (livePhoto, info) in
            
        }
    }
    

}
//MARK: changeObserver
extension HLAssetViewController:PHPhotoLibraryChangeObserver{
    func photoLibraryDidChange(_ changeInstance: PHChange) {
        
    }
    
}
//MARK: scrollViewDelegate
extension HLAssetViewController:UIScrollViewDelegate{
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        print(#function)
    }
    
}
