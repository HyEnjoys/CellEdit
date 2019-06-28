//
//  CustomCell.swift
//  SideSlipCell
//
//  Created by YuanGu on 2018/1/29.
//  Copyright © 2018年 YuanGu. All rights reserved.
//

import UIKit

class CustomCell: SideslipCell {

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
