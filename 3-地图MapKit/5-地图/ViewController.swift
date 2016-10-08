//
//  ViewController.swift
//  5-地图
//
//  Created by 蒋鹏 on 16/9/30.
//  Copyright © 2016年 蒋鹏. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        JKLocationManager.shared.startUpdatingLocation()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "地图", style: .plain, target: self, action: #selector(ViewController.pushMapVC))
    }

    final func pushMapVC() {
        let mapVC = JKMapViewController.init()
        self.navigationController?.pushViewController(mapVC, animated: true)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

