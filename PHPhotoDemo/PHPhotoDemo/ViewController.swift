//
//  ViewController.swift
//  PHPhotoDemo
//
//  Created by 于洪礼 on 2019/1/26.
//  Copyright © 2019 yuhongli. All rights reserved.
//

import UIKit


class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    
    var result = HLPhotoManager.default().getAllCollections()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let nib = UINib.init(nibName: PhotoColictionCell.cellIdentifier, bundle: Bundle.main)
        
        tableView.register(nib, forCellReuseIdentifier: PhotoColictionCell.cellIdentifier)
        
        
        
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
                cell.titleLabel?.text = item.titleStr
                item.asyIconImage { (image, _) in
                    cell.iconImage.image = image
                    
                }
            }
            return cell
        }else{
            let cell = UITableViewCell(frame: .zero)
            return cell
        }
        
    }
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 80
//    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if result.count > indexPath.row {
            let r = result[indexPath.row]
            
            let vc = HLAlbumViewController(r.getPhotoModel())
            self.navigationController?.pushViewController(vc, animated: true)
            
        }
        
    }
    
    
}

