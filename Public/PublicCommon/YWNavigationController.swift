//
//  YWNavigationController.swift
//  WeiboSwiftWang66
//
//  Created by wang66 on 2017/6/8.
//  Copyright © 2017年 renmaituan. All rights reserved.
//

import UIKit

class YWNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }


    // MARK - 重写navC的push方法，控制底部的tabBar是否隐藏
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if childViewControllers.count > 0 {
            viewController.hidesBottomBarWhenPushed = true
        }else {
            viewController.hidesBottomBarWhenPushed = false
        }
        super.pushViewController(viewController, animated: animated)
    }

}
