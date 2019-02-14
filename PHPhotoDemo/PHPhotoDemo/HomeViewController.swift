//
//  HomeViewController.swift
//  PHPhotoDemo
//
//  Created by 于洪礼 on 2019/1/27.
//  Copyright © 2019 yuhongli. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func click(_ sender: Any) {
        let _ = HLPhotoStatus { (successed) in
            if successed{
                let nav = self.storyboard?.instantiateViewController(withIdentifier: "PhotoNav") as! UINavigationController
                
                let vc = HLAlbumViewController()
                
                
                print("vc===\(vc)")
                
                nav.viewControllers.append(vc)
                self.present(nav, animated: true, completion: nil)
            }else{
                print("未授权去授权")
            }
            
        }
        
    }
    
}
