//
//  HomeViewController.swift
//  WeiboSwiftWang66
//
//  Created by wang66 on 2017/6/6.
//  Copyright © 2017年 renmaituan. All rights reserved.
//

import UIKit

let weiboCellId = "weiboCellId"


class HomeViewController: BasicViewController, UITableViewDataSource, UITableViewDelegate {

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setLeftImage(leftImage: nil)

        loadContentView()
    }
    
    
    
    func loadContentView() {
        view.addSubview(tableView)
    }

    
    
    // MARK - tableView and tableView delegate

    lazy var tableView: UITableView = {
        
        let tableView: UITableView = UITableView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height-52-64), style: .plain)
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
        tableView.dataSource = self as UITableViewDataSource
        tableView.delegate = self
        tableView.register(WeiboCell.self, forCellReuseIdentifier: weiboCellId)
        return tableView
    }()
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView .dequeueReusableCell(withIdentifier: weiboCellId, for: indexPath) as! WeiboCell

        let model = WeiboModel()
        model.contentStr = "有一天奥特曼在上课，老师问了一个问题，奥特曼想举手回答，然后老师就死了。"
        model.image = UIImage(named: "tabbar_compose_review")
        
        cell.refreshContent(model: model)
        return cell
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.navigationController?.pushViewController(HomeDetailViewController(), animated: true)
    }
    
    
    
    // MARK - override
    override func rightItemClick() {
        
        
        if !popMenu.isShow {
            popMenu.showMenu(inView: self.view, point: CGPoint(x: UIScreen.main.bounds.size.width-0.0, y: 0.0))
        }else {
            popMenu.hideMenu()
        }
        
        
    }
    
    
    // MARK - 懒加载
    lazy var popMenu: YWPopMenu = {
        let menuItems = [("tabbar_discover", "发起群聊"),("tabbar_discover", "添加朋友"),("tabbar_discover", "扫一扫"),("tabbar_discover", "收付款")]
        let popMenu = YWPopMenu(items: menuItems)
        popMenu.didSelectMenuItem = {(icon: String, title: String)->(Void) in
//            let alert = UIAlertView(title: "", message: "您选中了\(title)", delegate: self, cancelButtonTitle: "取消")
//            alert.show()
            print("您选中了[\(title)]")
        }
        return popMenu
    }()
    
    
    
    
    
    
    
    
    
    
    
    
    
    

}
