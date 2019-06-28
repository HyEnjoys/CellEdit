//
//  SideSlipController.swift
//  SideSlipCell
//
//  Created by YuanGu on 2018/1/29.
//  Copyright © 2018年 YuanGu. All rights reserved.
//

import UIKit

let SideSlipResue = "SideSlipIdentifier"

class SideSlipController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "SideSlipCell"
        
        view.backgroundColor = UIColor.white
        
        tableView.register(CustomCell.self, forCellReuseIdentifier: SideSlipResue)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: tableView
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SideSlipResue)
        cell?.textLabel?.textColor = UIColor.black
        cell?.textLabel?.textAlignment = .center
        cell?.textLabel?.text = "\(indexPath.row)"
        (cell as! SideslipCell).delegate = self
        return cell!
    }
}

extension SideSlipController: SideslipCellDelegate{
    func sideslipCell(_ sideslipCell: SideslipCell, editActionsForRowAt indexPath: IndexPath) -> [SideslipCellAction]? {
        let action1 = SideslipCellAction.rowAction(with: SideslipCellActionStyle.normal, title: "删除1", fontSize: 18, titleColor: UIColor.black, image: UIImage(), back: UIColor.clear) { (action, indexPath) in
            
        }
        let action2 = SideslipCellAction.rowAction(with: SideslipCellActionStyle.normal, title: "删除2", fontSize: 18, titleColor: UIColor.black, image: UIImage(), back: UIColor.clear) { (action, indexPath) in
            
        }
        
        return [action1 ,action2]
    }
}
