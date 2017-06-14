//
//  YWActionSheet.swift
//  WeiboSwiftWang66
//
//  Created by wang66 on 2017/6/8.
//  Copyright © 2017年 renmaituan. All rights reserved.
//

import UIKit

class YWActionSheet: UIView, UITableViewDataSource, UITableViewDelegate {


    let cellId = "cellId"
    // MARK - property
    var dataItems: [PayTypeModel]?
    var selectedPayTypeBlock: ((PayTypeModel)->())?
    
    var bgView: UIView!
    var sheetBgView: UIView!
    var tableView: UITableView!
    
    
    
    
    
    // MARK - init
    
   init(items: [PayTypeModel]) {
    
        super.init(frame: CGRect.zero)
        dataItems = items
        loadContentView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // load content view
    
    func loadContentView() {
        
        // bgView
        bgView = UIView()
        self.addSubview(bgView)
        bgView.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(0)
            make.right.equalTo(self).offset(0)
            make.top.equalTo(self).offset(0)
            make.bottom.equalTo(self).offset(0)
        }
        
        // sheetBgView
        sheetBgView = UIView()
        sheetBgView.backgroundColor = UIColor.green
        bgView.addSubview(sheetBgView)
        sheetBgView.snp.makeConstraints({ (make) in
            make.left.equalTo(bgView).offset(0)
            make.right.equalTo(bgView).offset(0)
            make.top.equalTo(bgView.snp.bottom).offset(0)
            make.height.equalTo(((dataItems?.count)!+1)*45+10)
        })
        
        
        // titleLab
        let titleLab = UILabel()
        titleLab.font = FONT(16)
        titleLab.textColor = UIColor.gray
        titleLab.textAlignment = .center
        titleLab.backgroundColor = UIColor.white
        titleLab.text = "选择支付方式"
        sheetBgView.addSubview(titleLab)
        titleLab.snp.makeConstraints { (make) in
            make.left.equalTo(sheetBgView).offset(0)
            make.right.equalTo(sheetBgView).offset(0)
            make.top.equalTo(sheetBgView).offset(0)
            make.height.equalTo(44)
        }
        
        // tableView
        tableView = UITableView(frame: CGRect.zero, style: .plain)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
        tableView.isScrollEnabled = false
        tableView.register(SheetCell.self, forCellReuseIdentifier: cellId)
        sheetBgView.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.left.equalTo(sheetBgView).offset(0)
            make.right.equalTo(sheetBgView).offset(0)
            make.top.equalTo(titleLab.snp.bottom).offset(0)
            make.bottom.equalTo(sheetBgView.snp.bottom).offset(0)
        }
        
    }
    
    
    
    // MARK - tableView delegate
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (dataItems?.count)!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45.0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let sheetCell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as!  SheetCell
        sheetCell.refreshContent(payModel: (dataItems?[indexPath.row])!)
        return sheetCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let payModel = dataItems?[indexPath.row]
        if selectedPayTypeBlock != nil{
            selectedPayTypeBlock!(payModel!)
        }
        self.perform(#selector(hide), with: nil, afterDelay: 0.2)
    }
    
    
    
    
    // show and hide
    
    func show() {
        
        let keyWindow = UIApplication.shared.keyWindow
        keyWindow?.addSubview(self)
        self.frame = (keyWindow?.frame)!
        keyWindow?.layoutIfNeeded()
        
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseOut, animations: {
            self.backgroundColor = UIColor(white: 0, alpha: 0.2)
            // 自动布局的动画：移除原有约束，然后重新添加新约束，最后调用layoutIfNeeded立即重新布局(注意，是该视图的父类调用)
            self.sheetBgView.snp.removeConstraints()
            self.sheetBgView.snp.makeConstraints({ (make) in
                make.left.equalTo(self.bgView).offset(0)
                make.right.equalTo(self.bgView).offset(0)
                make.top.equalTo(self.bgView.snp.bottom).offset(-((self.dataItems?.count)!+1)*45-10)
                make.height.equalTo(((self.dataItems?.count)!+1)*45+10)
            })
            self.bgView.layoutIfNeeded()
            
            
        }) { (Bool) in
            
        };
    }
    
    
    
    func hide() {
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseOut, animations: {
            
            self.backgroundColor = UIColor(white: 0, alpha: 0.0)
            
            self.sheetBgView.snp.removeConstraints()
            self.sheetBgView.snp.makeConstraints({ (make) in
                make.left.equalTo(self.bgView).offset(0)
                make.right.equalTo(self.bgView).offset(0)
                make.top.equalTo(self.bgView.snp.bottom).offset(0)
                make.height.equalTo(((self.dataItems?.count)!+1)*45+10)
            })
            self.bgView.layoutIfNeeded()

            
        }) { (Bool) in
            self.removeFromSuperview()
        }
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {

        let touch = touches.first
        let touchPoint = touch?.location(in: self)
        
        if sheetBgView.frame.contains(touchPoint!) {
            
        }else {
            self.hide()
        }
    }
    
}



// MARK - 自定义cell

class SheetCell: UITableViewCell {
    
    
    // MARK - property
    var imgV: UIImageView?
    var titleLab: UILabel?
    
    
    
    // MARK - init
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        loadCellContentView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func loadCellContentView() {
        
        imgV = UIImageView()
        imgV?.contentMode = .scaleAspectFit
        self.addSubview(imgV!)
        imgV?.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(15)
            make.centerY.equalTo(self).offset(0)
            make.width.equalTo(30)
            make.height.equalTo(30)
        }
        
        titleLab = UILabel()
        titleLab?.font = FONT(15)
        titleLab?.textColor = UIColor.lightGray
//        titleLab?.backgroundColor = UIColor.orange
        self.addSubview(titleLab!)
        titleLab?.snp.makeConstraints { (make) in
            make.left.equalTo((imgV?.snp.right)!).offset(10)
            make.right.equalTo(self).offset(-15)
            make.centerY.equalTo(self).offset(0)
        }
        
//        let bottomLine = UIView()
//        bottomLine.backgroundColor = UIColor.lightGray
//        self.addSubview(bottomLine)
//        bottomLine.snp.makeConstraints { (make) in
//            make.left.equalTo(self).offset(0)
//            make.right.equalTo(self).offset(0)
//            make.bottom.equalTo(self).offset(0)
//            make.height.equalTo(0.5)
//        }
        

    }
    
    
    fileprivate func refreshContent(payModel: PayTypeModel) {
        imgV?.image = UIImage(named:payModel.iconName!)
        titleLab?.text = payModel.title
    }
}



class PayTypeModel: NSObject {
    var iconName: String?
    var title: String?
    
    
    init(iconName: String, title: String) {
        super.init()
        self.iconName = iconName
        self.title = title
    }
    
    
}
