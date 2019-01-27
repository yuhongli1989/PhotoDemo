//
//  ViewController.swift
//  PHPhotoDemo
//
//  Created by 于洪礼 on 2019/1/26.
//  Copyright © 2019 yuhongli. All rights reserved.
//

import UIKit
import Photos

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    let imageManager = PHImageManager()
    let cacheManager = PHCachingImageManager()
    
    var result = [PHAssetCollection]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        PHPhotoLibrary.shared().register(self)
        let nib = UINib.init(nibName: PhotoColictionCell.cellIdentifier, bundle: Bundle.main)
        
        tableView.register(nib, forCellReuseIdentifier: PhotoColictionCell.cellIdentifier)
        
        let options = PHFetchOptions()
        
        let collectionItems = PHAssetCollection.fetchAssetCollections(with: .smartAlbum, subtype: .any, options: options)
        collectionItems.enumerateObjects({[weak self] (collection, i, _) in
            
            if collection.assetCollectionSubtype == .smartAlbumUserLibrary{
                self?.result.insert(collection, at: 0)
            }else{
                self?.result.append(collection)
            }
            
            
            
        })
        
        
    }
    
    deinit {
        PHPhotoLibrary.shared().unregisterChangeObserver(self)
    }
    
    @IBAction func backClick(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    

}

extension ViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return result.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if result.count > 0 {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: PhotoColictionCell.cellIdentifier, for: indexPath) as! PhotoColictionCell
            if result.count > 0{
                let item = result[indexPath.row]
                let assets = PHAsset.fetchAssets(in: item, options: nil)
                cell.titleLabel.text = NSLocalizedString("\(item.localizedTitle ?? "")", comment: "") + "(\(assets.count))"
                if let firstImage = assets.firstObject{
                    let scale = UIScreen.main.scale
                    cell.localIdentifier = firstImage.localIdentifier
                    
                    cacheManager.requestImage(for: firstImage, targetSize: CGSize(width: 64*scale, height: 64*scale), contentMode: .default, options: nil) { (image, _) in
                        if cell.localIdentifier == firstImage.localIdentifier{
                            cell.iconImage.image = image
                        }else{
                            cell.iconImage.image = nil
                        }
                        
                    }
                    
                }else{
                    cell.iconImage.image = nil
                }
            }
            return cell
        }else{
            let cell = UITableViewCell(frame: .zero)
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if result.count > indexPath.row {
            let r = result[indexPath.row]
            let vc = HLAlbumViewController(r)
            self.navigationController?.pushViewController(vc, animated: true)
            
        }
        
    }
    
    
}

extension ViewController:PHPhotoLibraryChangeObserver{
    func photoLibraryDidChange(_ changeInstance: PHChange) {
        print(#function)
    }
    
    
}
