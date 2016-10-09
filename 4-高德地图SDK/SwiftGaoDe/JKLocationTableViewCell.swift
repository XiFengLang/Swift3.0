//
//  JKLocationTableViewCell.swift
//  5-地图
//
//  Created by 蒋鹏 on 16/10/8.
//  Copyright © 2016年 蒋鹏. All rights reserved.
//

import UIKit

class JKLocationTableViewCell: UITableViewCell {

    static let locationCellReuseKey = "JKLocationTableViewCellKey"
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    class func registerCell(withTableView tableView: UITableView) -> (){
        tableView.register(JKLocationTableViewCell.classForCoder(), forCellReuseIdentifier: locationCellReuseKey)
    }
    

    class func cell(withTableView tableView: UITableView) -> JKLocationTableViewCell{
        var cell: JKLocationTableViewCell? = tableView.dequeueReusableCell(withIdentifier: locationCellReuseKey) as? JKLocationTableViewCell
        if (cell == nil) {
            cell = JKLocationTableViewCell.init(style: .subtitle, reuseIdentifier: locationCellReuseKey)
            cell?.selectionStyle = .none
        }
        return cell!
    }
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.backgroundColor = UIColor.white
        self.accessoryView?.tintColor = UIColor.red
        self.detailTextLabel?.font = UIFont.systemFont(ofSize: 16)
        self.textLabel?.font = UIFont.systemFont(ofSize: 18)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if (selected) {
            self.accessoryType = .checkmark;
        } else {
            self.accessoryType = .none;
        }
    }
}
