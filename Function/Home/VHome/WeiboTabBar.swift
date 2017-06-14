//
//  WeiboTabBar.swift
//  WeiboSwiftWang66
//
//  Created by wang66 on 2017/6/6.
//  Copyright © 2017年 renmaituan. All rights reserved.
//

import UIKit

class WeiboTabBar: UITabBar {


    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI() //  创建UI
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // 更新视图的布局
    override func layoutSubviews() {
        super.layoutSubviews()
        
        publishBtn.center.x = self.bounds.size.width/2
        publishBtn.center.y = self.bounds.size.height/2
        
        
        var index = 0
        for subView in self.subviews
        {
            if subView.isKind(of: NSClassFromString("UITabBarButton")!){
                let barBtn_Width = self.bounds.size.width/5
                subView.frame.origin.x = barBtn_Width*CGFloat(index)
                subView.frame.size.width = barBtn_Width
                
                index += 1
                
                if index==2 {
                    index += 1
                }
            }
        }
    }
    
    
    func setupUI() {
        addSubview(publishBtn)
    }
    
    
    // swift中的懒加载和OC中有很大不同，swift的懒加载只执行一次，它的本质是个闭包
    lazy var publishBtn: UIButton = {/*() -> UIButton in*/
        let publishBtn = UIButton()
        publishBtn.setImage(#imageLiteral(resourceName: "tabbar_compose_icon_add"), for: .normal)
        publishBtn.setImage(#imageLiteral(resourceName: "tabbar_compose_icon_add_highlighted"), for: .highlighted)
        publishBtn.setBackgroundImage(#imageLiteral(resourceName: "tabbar_compose_button"), for: .normal)
        publishBtn.setBackgroundImage(#imageLiteral(resourceName: "tabbar_compose_button_highlighted"), for: .highlighted)
        publishBtn.addTarget(self, action: #selector(publishBtnClick(btn:)), for: .touchUpInside)
        publishBtn.sizeToFit()
        
        return publishBtn
    }()
    
    
    var publishBtnBlock: ((UIButton)->())? // swift中怎么定义block
    
    // 在按钮的点击事件方法中进行block回调
    func publishBtnClick(btn: UIButton) {
        publishBtnBlock!(btn)
    }

}
