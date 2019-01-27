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
        return img
    }()
    
    init(_ asset:PHAsset) {
        photoAsset = asset
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
        if photoAsset.mediaSubtypes.contains(.photoLive) {
            
        }else{
            uploadStaticImage()
        }
        
        
        // Do any additional setup after loading the view.
    }
    
    func uploadStaticImage()  {
        
        let options = PHImageRequestOptions()
        options.isNetworkAccessAllowed = true
        options.deliveryMode = .highQualityFormat
        
        
        PHImageManager.default().requestImage(for: photoAsset, targetSize: imageView.bounds.size, contentMode: .aspectFit, options: options) {[weak self] (image, _) in
            
            print("image===\(image)")
            self?.imageView.image = image
            
            print("aaaaaa")
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

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
