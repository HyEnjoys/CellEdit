//
//  ResetController.swift
//  SideSlipCell
//
//  Created by YuanGu on 2018/1/29.
//  Copyright © 2018年 YuanGu. All rights reserved.
//

import UIKit

let ResetResue = "ResetIdentifier"
class ResetController: UITableViewController {

    var editIndexpath: NSIndexPath?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "左滑控件"
        
        view.backgroundColor = UIColor.white
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: ResetResue)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: tableView
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ResetResue)
        cell?.textLabel?.textColor = UIColor.black
        cell?.textLabel?.textAlignment = .center
        cell?.textLabel?.text = "\(indexPath.row)"
        return cell!
    }
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let rowAction1 = UITableViewRowAction.init(style: UITableViewRowAction.Style.default, title: "删除1") { (action, indexPath) in
            print("删除1")
        }
        
        let rowAction2 = UITableViewRowAction.init(style: UITableViewRowAction.Style.normal, title: "删除2") { (action, indexPath) in
            print("删除2")
        }
        
        return [rowAction1 ,rowAction2]
    }
    
    //记录开始编辑的cell下标
    override func tableView(_ tableView: UITableView, willBeginEditingRowAt indexPath: IndexPath) {
        editIndexpath = indexPath as NSIndexPath
        
        view.setNeedsLayout()
    }
    override func tableView(_ tableView: UITableView, didEndEditingRowAt indexPath: IndexPath?) {
        editIndexpath = nil
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        if editIndexpath != nil {
            configSwipeButton()
        }
    }
    // MARK: cell Edit button
    func configSwipeButton() {
        
        if #available(iOS 12.0, *) {
            // iOS 11层级 (Xcode 9编译): UITableView -> UISwipeActionPullView -> UISwipeActionStandardButton -> UIView + UIButtonLabel
            for view: UIView in tableView.subviews {
                // 和iOS 10的按钮顺序相反
                if view.isKind(of: NSClassFromString("UISwipeActionPullView")!) {
                    let button = UIButton(frame: view.frame)
                    button.addTarget(self, action: #selector(addButton), for: .touchUpInside)
                    button.setTitle("+++", for: .normal)
                    button.setTitleColor(.black, for: .normal)
                    view.addSubview(button)
                }
            }
        } else if #available(iOS 11.0, *) {
            // iOS 11层级 (Xcode 9编译): UITableView -> UISwipeActionPullView
            for view: UIView in tableView.subviews {
                // 和iOS 10的按钮顺序相反
                if view.isKind(of: NSClassFromString("UISwipeActionPullView")!) {
                    // let button = view as! UIButton
                    let button: UIButton = view as! UIButton
                    setButton(button: button)
                }
            }
        } else {            // iOS 8-10层级 (Xcode 8编译): UITableView -> UITableViewCell -> UITableViewCellDeleteConfirmationView
            let cell = tableView.cellForRow(at: editIndexpath! as IndexPath)
            
            for view: UIView in (cell?.subviews)! {
                if view.isKind(of: NSClassFromString("UITableViewCellDeleteConfirmationView")!) {
                    let button = view as! UIButton
                    setButton(button: button)
                }
            }
        }
    }
    
    func setButton(button: UIButton) {
        button.backgroundColor = UIColor.orange
        button.setTitleColor(UIColor.blue, for: .normal)
    }
    
    @objc func addButton() {
        print("----")
    }
}
