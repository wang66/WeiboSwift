//
//  MineViewController.swift
//  WeiboSwiftWang66
//
//  Created by wang66 on 2017/6/6.
//  Copyright © 2017年 renmaituan. All rights reserved.
//

import UIKit


var mineCellId = "mineCellId"
var userInfoCellId = "userInfoCellId"


class UserInfoModel: NSObject {
    var headPortrait: String?
    var nickname: String?
    var desc: String?
    var weiboCount: Int?
    var followCount: Int?
    var fansCount: Int?
}



class MineListModel: NSObject {
    
    let iconImg: UIImage?
    let listTitle: String?
    let listSubTitle: String?
    var userInfo: UserInfoModel?
    
    
    init(icon: UIImage?, title: String?, subTitle: String?) {
        
        iconImg = icon
        listTitle = title
        listSubTitle = subTitle
        userInfo = nil
        super.init()
    }
    
    convenience init(user: UserInfoModel) {
        self.init(icon: nil, title: nil, subTitle: nil)
        userInfo = user
    }
    

}


class TableDataModel: NSObject {
    
    var rowIndex = 0
    var rowsDataArr = [MineListModel]()
    
    init(index: Int, dataArr: [MineListModel]) {
        rowIndex = index
        rowsDataArr = dataArr
    }
}





class MineViewController: BasicViewController, UITableViewDelegate, UITableViewDataSource {

    
    var tableDataArr = [TableDataModel]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let leftItem = UIBarButtonItem(title: "添加好友", style: .plain, target: self, action: #selector(addFriend))
        leftItem.tintColor = UIColor.lightGray
        self.navigationItem.leftBarButtonItem = leftItem
        
        let rightItem = UIBarButtonItem(title: "设置", style: .plain, target: self, action: #selector(setting))
        rightItem.tintColor = UIColor.lightGray
        self.navigationItem.rightBarButtonItem = rightItem
        
        view.addSubview(tableView)
        
        // ============= 数据源 =================
        // section0
        let userInfoModel = UserInfoModel()
        userInfoModel.nickname = "wen_zqs"
        userInfoModel.desc = "随风潜入夜，润物细无声"
        userInfoModel.headPortrait = ""
        userInfoModel.weiboCount = 485
        userInfoModel.followCount = 438
        userInfoModel.fansCount = 293
        let section0_row0_model = MineListModel(user: userInfoModel)
        let section0_model = TableDataModel(index: 0, dataArr: [section0_row0_model])
        tableDataArr.append(section0_model)
        
        // section1
        let section1_row0_model = MineListModel(icon: #imageLiteral(resourceName: "tabbar_message_center_selected"), title: "添加好友 ", subTitle: "")
        let section1_model = TableDataModel(index: 0, dataArr: [section1_row0_model])
        tableDataArr.append(section1_model)
        
        // section2
        let section2_row0_model = MineListModel(icon: #imageLiteral(resourceName: "tabbar_message_center_selected"), title: "我的相册 ", subTitle: "")
        let section2_row1_model = MineListModel(icon: #imageLiteral(resourceName: "tabbar_message_center_selected"), title: "我的赞 ", subTitle: " 收藏，移到这里了")
        let section2_model = TableDataModel(index: 0, dataArr: [section2_row0_model, section2_row1_model])
        tableDataArr.append(section2_model)
        
        // section3
        let section3_row0_model = MineListModel(icon: #imageLiteral(resourceName: "tabbar_message_center_selected"), title: "微博钱包 ", subTitle: " 邀好友来拿钱")
        let section3_row1_model = MineListModel(icon: #imageLiteral(resourceName: "tabbar_message_center_selected"), title: "微博运动 ", subTitle: " 反手合十，炫技赢红包")
        let section3_row2_model = MineListModel(icon: #imageLiteral(resourceName: "tabbar_message_center_selected"), title: "免流量 ", subTitle: " 刷微博，看视频")
        let section3_model = TableDataModel(index: 0, dataArr: [section3_row0_model, section3_row1_model, section3_row2_model])
        tableDataArr.append(section3_model)
        
        
        // section4
        let section4_row0_model = MineListModel(icon: #imageLiteral(resourceName: "tabbar_message_center_selected"), title: "粉丝服务 ", subTitle: " 写文章，发点评，赚粉丝")
        let section4_row1_model = MineListModel(icon: #imageLiteral(resourceName: "tabbar_message_center_selected"), title: "粉丝头条 ", subTitle: " 推广博文及帐号的利器")
        let section4_model = TableDataModel(index: 0, dataArr: [section4_row0_model, section4_row1_model])
        tableDataArr.append(section4_model)
        
        
        // section5
        let section5_row0_model = MineListModel(icon: #imageLiteral(resourceName: "tabbar_message_center_selected"), title: "客服中心 ", subTitle: "")
        let section5_model = TableDataModel(index: 0, dataArr: [section5_row0_model])
        tableDataArr.append(section5_model)
        
        // section6
        let section6_row0_model = MineListModel(icon: #imageLiteral(resourceName: "tabbar_message_center_selected"), title: "草稿箱 ", subTitle: "")
        let section6_model = TableDataModel(index: 0, dataArr: [section6_row0_model])
        tableDataArr.append(section6_model)
        // ============= 数据源 =================
        
        
        
    }
    
    
    func addFriend() {
        
    }
    
    func setting() {
        
    }
    
    
    
    
   
    
    // MARK - tableView and delegate
    
    lazy var tableView: UITableView = {
        let tableView: UITableView = UITableView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height-52-64), style: .grouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
        tableView.register(MineListCell.self, forCellReuseIdentifier: mineCellId)
        tableView.register(UserInfoCell.self, forCellReuseIdentifier: userInfoCellId)
        return tableView
    }()
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return tableDataArr.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let sectionModel = tableDataArr[section] as TableDataModel
        return sectionModel.rowsDataArr.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10.0
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.section==0 {
            return 120
        }
        return 40
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let sectionModel = tableDataArr[indexPath.section] as TableDataModel
        let rowModel = sectionModel.rowsDataArr[indexPath.row] as MineListModel
        
        if indexPath.section==0 && indexPath.row == 0 {
            let userInfoCell = tableView.dequeueReusableCell(withIdentifier: userInfoCellId, for: indexPath) as! UserInfoCell
            userInfoCell.refreshContent(userInfo: rowModel.userInfo!)
            return userInfoCell
        }
        
        let listCell = tableView.dequeueReusableCell(withIdentifier: mineCellId, for: indexPath) as! MineListCell
        listCell.refreshContent(model: rowModel)
        return listCell
        
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    

}
