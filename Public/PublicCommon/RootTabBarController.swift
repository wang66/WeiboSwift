//
//  RootTabBarController.swift
//  WeiboSwiftWang66
//
//  Created by wang66 on 2017/6/6.
//  Copyright © 2017年 renmaituan. All rights reserved.
//

import UIKit

class RootTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let weiboTabBar = WeiboTabBar()
        
        weiboTabBar.publishBtnBlock = { (btn:UIButton)->() in
//            self.present(PublishViewController(), animated: true, completion: nil)
            
//            let alert = UIAlertView(title: "不温馨提示", message: "正在开发调教中", delegate: self, cancelButtonTitle: "取消")
//            alert.show()
            
            self.publishAlert.showPublishAlert()
            
            
        }
        
//        self.tabBar = weiboTabBar
        self.setValue(weiboTabBar, forKey: "tabBar") // tabBarController的tabBar是只读的，所以只能用KVC赋值
        
        addChildViewController(viewController: HomeViewController(), title: "首页", imageName: "tabbar_home", selectImageName: "tabbar_home_selected")
        addChildViewController(viewController: MessageViewController(), title: "消息", imageName: "tabbar_message_center", selectImageName: "tabbar_message_center_selected")
        addChildViewController(viewController: DiscoverViewController(), title: "发现", imageName: "tabbar_discover", selectImageName: "tabbar_discover_selected")
        addChildViewController(viewController: MineViewController(), title: "我", imageName: "tabbar_profile", selectImageName: "tabbar_profile_selected")
    }

    
    
    func addChildViewController(viewController: UIViewController, title: String, imageName:String, selectImageName:String) {
        viewController.title = title
        viewController.tabBarItem.image = UIImage(named: imageName)?.withRenderingMode(.alwaysOriginal)
        viewController.tabBarItem.selectedImage = UIImage(named: selectImageName)?.withRenderingMode(.alwaysOriginal)
        viewController.tabBarItem.setTitleTextAttributes([NSFontAttributeName: UIFont.systemFont(ofSize: 12), NSForegroundColorAttributeName:UIColor.lightGray], for: .normal)
        viewController.tabBarItem.setTitleTextAttributes([NSFontAttributeName:UIFont.systemFont(ofSize: 12), NSForegroundColorAttributeName:UIColor.orange], for: .selected)
        let navC = YWNavigationController(rootViewController: viewController)
        addChildViewController(navC)
    }
    
    
    
    lazy var publishAlert: PublishAlertView = {
        let publishAlert = PublishAlertView(items: [("文字", "tabbar_compose_idea_neo"),
                                                    ("拍摄", "tabbar_compose_slideshow_neo"),
                                                    ("相册", "tabbar_compose_picture_neo"),
                                                    ("直播", "tabbar_compose_live_neo"),
                                                    ("光影秀", "tabbar_compose_video_neo"),
                                                    ("头条文章", "tabbar_compose_article_neo"),
                                                    ("签到", "tabbar_compose_location_neo"),
                                                    ("点评", "tabbar_compose_comment_neo"),
                                                    ("话题", "tabbar_compose_topic_neo"),
                                                    ("红包", "tabbar_compose_friends_neo"),
                                                    ("好友圈", "tabbar_compose_more"),
                                                    ("音乐", "tabbar_compose_music_neo"),
                                                    ("商品", "tabbar_compose_shopping_neo"),
                                                    ("秒拍", "tabbar_compose_miaopai_neo"),])
        return publishAlert
    }()
    
    

}
