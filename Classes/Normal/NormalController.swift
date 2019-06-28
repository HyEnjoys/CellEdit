//
//  NormalController.swift
//  SideSlipCell
//
//  Created by YuanGu on 2018/1/29.
//  Copyright © 2018年 YuanGu. All rights reserved.
//

import UIKit

let NormalResue = "NormalIdentifier"

class NormalController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "正常cell左滑"
        
        view.backgroundColor = UIColor.white
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: NormalResue)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NormalResue)
        cell?.textLabel?.textColor = UIColor.black
        cell?.textLabel?.textAlignment = .center
        cell?.textLabel?.text = "\(indexPath.row)"
        return cell!
    }
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
//    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
//        let rowAction1 = UITableViewRowAction.init(style: UITableViewRowAction.Style.default, title: "删除1") { (action, indexPath) in
//            print("删除1")
//        }
//
//        let rowAction2 = UITableViewRowAction.init(style: UITableViewRowAction.Style.normal, title: "删除2") { (action, indexPath) in
//            print("删除2")
//        }
//
//        return [rowAction1 ,rowAction2]
//    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        if #available(iOS 11.0, *) {
            let delete = UIContextualAction(style: .destructive, title: "删除") { ( _, v, closure) in
                // tableView.deleteRows(at: [indexPath], with: .bottom)
            }
            delete.backgroundColor = UIColor.gray
            delete.image = UIImage(named: "tabbar_discover")
            return UISwipeActionsConfiguration(actions: [delete])
        }
        return nil
    }
}
