//
//  BasicViewController.swift
//  WeiboSwiftWang66
//
//  Created by wang66 on 2017/6/6.
//  Copyright © 2017年 renmaituan. All rights reserved.
//

import UIKit

class BasicViewController: UIViewController, UIGestureRecognizerDelegate {
    
    init() {
//        super.init()
        super.init(nibName: nil, bundle: nil)
        
        automaticallyAdjustsScrollViewInsets = false
        extendedLayoutIncludesOpaqueBars = false
        edgesForExtendedLayout = .init(rawValue: 0) // 在swift中怎么没none 对应OC：self.edgesForExtendedLayout = UIRectEdgeNone;
        
        self.navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName: FONT(13), NSForegroundColorAttributeName: UIColor.lightGray]
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        
        view.backgroundColor = UIColor.white
        self.setLeftImage(leftImage: UIImage(named: "tabbar_compose_background_icon_return"))
        self.setRightImage(rightImage: UIImage(named: "tabbar_profile_selected"))
        
        self.navigationController?.navigationBar.barStyle = .default
        // 添加全屏侧滑手势
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false // 先禁止系统自带的手势(从屏幕边缘滑起)
        let target = self.navigationController?.interactivePopGestureRecognizer?.delegate
//        let panGesture = UIPanGestureRecognizer(target: target, action: #selector("handleNavigationTransition:")))
        let panGesture = UIPanGestureRecognizer(target: target, action: Selector(("handleNavigationTransition:")))
        panGesture.delegate = self
        self.view.addGestureRecognizer(panGesture)
    }
    
    
    func setLeftImage(leftImage:UIImage?) {
        let leftImg = leftImage?.withRenderingMode(.alwaysOriginal)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: leftImg, style: .plain, target: self, action: #selector(leftItemClick))
        
    }
    
    func setRightImage(rightImage:UIImage?) {
        let rightImg = rightImage?.withRenderingMode(.alwaysOriginal)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: rightImg, style: .plain, target: self, action: #selector(rightItemClick))
        
    }
    
//    func setLeftTitle(leftTitle: String) {
//        
//        self.navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName: FONT(13), NSForegroundColorAttributeName: UIColor.lightGray]
//        
//    }
    
    
    func leftItemClick() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func rightItemClick() {
        let alert = UIAlertView(title: "", message: "点击了右上角的按钮", delegate: self, cancelButtonTitle: "取消")
        alert.show()
    }
    
    
    
    
    // MARK -
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        
        if navigationController?.viewControllers.count == 1 {
            return false
        }
        return true
    }
    
    

    
}
