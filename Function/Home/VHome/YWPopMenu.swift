//
//  YWPopMenu.swift
//  WeiboSwiftWang66
//
//  Created by wang66 on 2017/6/7.
//  Copyright © 2017年 renmaituan. All rights reserved.
//

import UIKit

let cellId = "cellId"


let pop_w: CGFloat = 110.0

let pop_h: CGFloat = 140.0



class YWPopMenu: UIView, UITableViewDataSource, UITableViewDelegate {
    
    var dataItems: [(String, String)]?
    
    var bgView: UIView!
    
    var menuBgView: UIImageView!
    
    var showPoint: CGPoint = CGPoint.zero
    var tableView: UITableView?
    
    var curSuperView: UIView?
    
    var isShow: Bool = false
    
    var didSelectMenuItem: (((String,String))->(Void))?
    
    
    
    
    // MARK - init
    init(items:[(String, String)]) {
        super.init(frame: CGRect.zero)
        dataItems = items
        loadContentView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK - load view
    
    func loadContentView() {
        
        // bgView
        bgView = UIView(frame: UIScreen.main.bounds)
        bgView.backgroundColor = UIColor.clear
        self.addSubview(bgView)
        
        
        // menuBgView
        menuBgView = UIImageView()
        menuBgView.isUserInteractionEnabled = true
        menuBgView.image = UIImage(named: "home_popMenu")?.resizableImage(withCapInsets: UIEdgeInsetsMake(30.0, 30.0, 20.0, 50.0), resizingMode:.stretch)
        bgView.addSubview(menuBgView)
        
        
        // tableView
        tableView = UITableView(frame: CGRect.zero, style: .plain)
        tableView?.dataSource = self
        tableView?.delegate = self
        tableView?.tableFooterView = UIView()
        tableView?.separatorStyle = .none
        tableView?.backgroundColor = UIColor.clear
        tableView?.register(PopMenuCell.self, forCellReuseIdentifier: cellId)
        menuBgView.addSubview(tableView!)
    }
    
    
    override func layoutSubviews() {
        self.frame = (curSuperView?.bounds)!
        bgView.frame = self.bounds
        menuBgView.frame = CGRect(x: showPoint.x-pop_w, y: showPoint.y, width: pop_w, height: pop_h)
        tableView?.frame = CGRect(x: 8.0, y: 12, width: pop_w-16.0, height: pop_h-22)
    }
    

    
    // MARK - tableView delegate
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4;
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return (pop_h-22)/CGFloat((dataItems?.count)!)
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId) as! PopMenuCell
        let content = dataItems?[indexPath.row]
        cell.refreshContent(content: content!)
        return cell
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
         let content = dataItems?[indexPath.row]
        if let selectMenuItemBlock = didSelectMenuItem {
            selectMenuItemBlock(content!)
        }
    }
    
    
    // MARK - public function method
    // show
    func showMenu(inView view: UIView?, point:CGPoint) {
        
        curSuperView = view
        showPoint = point
        isShow = true
        view?.addSubview(self)
        layoutIfNeeded()
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseOut, animations: {
            self.menuBgView.alpha = 1
        }) { (Bool) in
            
        };
    }
    
    // hide
    func hideMenu() {
        isShow = false
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseOut, animations: {
            self.menuBgView.alpha = 0
        }) { (Bool) in
            self.removeFromSuperview()
        }
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        let touchPoint = touch?.location(in: self)
        
        if menuBgView.frame.contains(touchPoint!) {
            
        }else {
            self.hideMenu()
        }
        
        
    }
    

}

