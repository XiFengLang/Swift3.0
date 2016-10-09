//
//  JKMapSearchViewController.swift
//  SwiftGaoDe
//
//  Created by 蒋鹏 on 16/10/9.
//  Copyright © 2016年 蒋鹏. All rights reserved.
//

import UIKit




class JKMapSearchViewController: UITableViewController {
    lazy var searchResults = {
        return [AnyObject]()
    }()
    
    
//    open var searchResults: [AMapTip]? {
//        willSet {
//            // set之前做些事
//        }
//        didSet {
//            // set之后做些事
//            self.tableView.reloadData()
//        }
//    }
    
    // 代理
    weak open var delegate: JKMapSearchViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.automaticallyAdjustsScrollViewInsets = false
        self.searchResults = []
        self.clearsSelectionOnViewWillAppear = true
        self.tableView.rowHeight = 55
        self.tableView.tableFooterView = UIView.init()
        self.tableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0)
        self.tableView.scrollIndicatorInsets = UIEdgeInsetsMake(64, 0, 0, 0)
        
    }

    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (self.searchResults.count)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: JKLocationTableViewCell = JKLocationTableViewCell.cell(withTableView: tableView) as JKLocationTableViewCell
        let tip = self.searchResults[indexPath.row]
        cell.textLabel?.text = tip.district
        cell.detailTextLabel?.text = tip.name
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let tip = self.searchResults[indexPath.row]
        self.delegate?.jkMapSearchViewController(didSelected: tip as! AMapTip)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}


// 协议
public protocol JKMapSearchViewControllerDelegate: NSObjectProtocol {
    
    func jkMapSearchViewController(didSelected item: AMapTip)
    
}
