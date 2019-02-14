//
//  HLAssetViewController.swift
//  PHPhotoDemo
//
//  Created by 于洪礼 on 2019/1/27.
//  Copyright © 2019 yuhongli. All rights reserved.
//

import UIKit


class HLAssetViewController: UIViewController {
    
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
    
    let photoItem:HLPhotoItem
    
    init(_ asset:HLPhotoItem) {
        photoItem = asset
        super.init(nibName: nil, bundle: nil)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        view.addSubview(scrollView)
        scrollView.addSubview(imageView)
        
        photoItem.asyGetImage {[weak self] (image, _) in
            self?.imageView.image = image
        }

        
        // Do any additional setup after loading the view.
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
