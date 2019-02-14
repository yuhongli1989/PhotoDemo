//
//  HLAlbumViewController.swift
//  PHPhotoDemo
//
//  Created by 于洪礼 on 2019/1/27.
//  Copyright © 2019 yuhongli. All rights reserved.
//

import UIKit


class HLAlbumViewController: UIViewController {

    @IBOutlet weak var layout: UICollectionViewFlowLayout!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    var availableWidth:CGFloat = 0
    
    var assetCollection:HLPhotoModelManager
    
    init(_ collection:HLPhotoModelManager? = nil) {
        if let col = collection {
            assetCollection = col
        }else{
            assetCollection = HLPhotoManager.default().getAllCachingImages()
        }
        super.init(nibName: "HLAlbumViewController", bundle: Bundle.main)

        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpCollection()
        setUp()
        print(#function)
        
        
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        print(#function)
        let width = view.bounds.inset(by: view.safeAreaInsets).width
        
        if availableWidth != width {
            availableWidth = width
            let columnCount = (availableWidth / 80).rounded(.towardZero)
            let itemLength = (availableWidth - columnCount - 1) / columnCount
            layout.itemSize = CGSize(width: itemLength, height: itemLength)
        }
    }
    
    //MARK:UIBarButtonItem
    func setUp()  {
        let btn = UIButton(frame: CGRect(x: 0, y: 0, width: 44, height: 44))
        let color = self.navigationController?.navigationBar.tintColor ?? UIColor.blue
        btn.addTarget(self, action: #selector(backRoot), for: .touchUpInside)
        btn.setTitle("取消", for: .normal)
        btn.setTitleColor(color, for: .normal)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: btn)
    }
    
    //MARK:initCollection
    func setUpCollection()  {
        layout.minimumLineSpacing = 1
        layout.minimumInteritemSpacing = 0
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(HLAlbumCell.self, forCellWithReuseIdentifier: "cell")
    }
    
    @objc func backClick(){
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func backRoot(){
        print(#function)
        self.dismiss(animated: true, completion: nil)
    }



}


//MARK: collection delegate
extension HLAlbumViewController:UICollectionViewDataSource,UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return assetCollection.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! HLAlbumCell
        
        if assetCollection.count > 0 {
            let burstIdentifier = assetCollection.getLocalIdentifier(indexPath.row) ?? ""
            
            cell.burstIdentifier = assetCollection.getLocalIdentifier(indexPath.row) ?? ""
            cell.iconImage.frame = CGRect(origin: .zero, size: layout.itemSize)

            assetCollection.asyGetCachImage(indexPath.row, layout.itemSize) { (image, dic) in
                
                if cell.burstIdentifier == burstIdentifier{
                    cell.iconImage.image = image
                }
                
            }
           
        }
        
        return cell
        
    }
    
    //MARK: cell点击
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let item = assetCollection[indexPath.row] else {
            return
        }
        let vc = HLAssetViewController(item)
        self.navigationController?.pushViewController(vc, animated: true)

        
    }
    
}
