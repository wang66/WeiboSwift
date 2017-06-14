//
//  PublishAlertView.swift
//  WeiboSwiftWang66
//
//  Created by wang66 on 2017/6/9.
//  Copyright © 2017年 renmaituan. All rights reserved.
//

import UIKit



class PublishAlertView: UIView, UIScrollViewDelegate, CAAnimationDelegate {
    
    /* 这些属性，可以确保在程序中都是有值的，所以不需要可选类型。
     并且直接在声明属性时赋初值，系统可以根据初值推断出其类型，所以并不需要类型标注
    */
    var bgView = UIToolbar()
    let closeBtn = UIButton()
    let bottomLine = UIView()
    let scrollView = UIScrollView()
    let pageControl = UIPageControl()
    
    let dataItems: [(title:String, image:String)]?
    let btn_w: CGFloat = 75.0
    
    // 计算型属性，且是get-only的
    var padding_x: CGFloat {
        get {
            return (Screen_Width-30-4*CGFloat(btn_w))/3
        }
    }
    
    // MARK - init

    init(items: [(title:String, image:String)]) {
        
        dataItems = items
        super.init(frame: CGRect.zero)
        
        loadConntentView()
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
    
    }


    
    
    func closeBtnClick(btn: UIButton) {
        hidePublishAlert()
    }
    
    
    func publishItemBtnClick(btn: PublishBtn) {
        let btnInfo = dataItems?[btn.tag-500]
        let alert = UIAlertView(title: "", message: "你点击了-\(btnInfo?.title ?? "")", delegate: self, cancelButtonTitle: "取消")
        alert.show()
    }
    
    
    // content view
    
    func loadConntentView() {
        
        // bgiew
        bgView.barStyle = .default
        self.addSubview(bgView)
        bgView.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(0)
            make.right.equalTo(self).offset(0)
            make.top.equalTo(self).offset(0)
            make.bottom.equalTo(self).offset(0)
        }
        
        // closeBtn
        closeBtn.setImage(IMAGE("tabbar_compose_background_icon_close"), for: .normal)
        closeBtn.addTarget(self, action: #selector(closeBtnClick(btn:)), for: .touchUpInside)
        closeBtn.transform = CGAffineTransform(rotationAngle: .pi/2)
        bgView.addSubview(closeBtn)
        closeBtn.snp.makeConstraints { (make) in
            make.centerX.equalTo(self).offset(0)
            make.bottom.equalTo(self).offset(0)
            make.height.equalTo(40)
            make.height.equalTo(40)
        }
        
        
        // bottomLine
        bottomLine.backgroundColor = UIColor(white: 0, alpha: 0.4)
        bgView.addSubview(bottomLine)
        bottomLine.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(0)
            make.right.equalTo(self).offset(0)
            make.bottom.equalTo(closeBtn.snp.top).offset(0)
            make.height.equalTo(0.5)
        }
        
        // scrollView
        scrollView.backgroundColor = UIColor.clear
        scrollView.contentSize = CGSize(width: Screen_Width*2, height: 0)
        scrollView.isPagingEnabled = true
        scrollView.isUserInteractionEnabled = true
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.delegate = self
        bgView.addSubview(scrollView)
        scrollView.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(0)
            make.right.equalTo(self).offset(0)
            make.bottom.equalTo(bottomLine.snp.top).offset(0)
            make.height.equalTo(280)
        }
        
        
        for index in 0..<dataItems!.count {
            let btnInfo = dataItems![index]
            let publishBtn = PublishBtn()
            let btn_x: CGFloat = index<8 ? 15+(btn_w+padding_x)*CGFloat(index%4) : Screen_Width+15+(btn_w+padding_x)*CGFloat((index-8)%4)
            let btn_y: CGFloat = index<8 ? 280+(btn_w+padding_x)*CGFloat(index/4) : 280+(btn_w+padding_x)*CGFloat((index-8)/4)
            publishBtn.frame = CGRect(x: btn_x, y: btn_y, width: btn_w, height: btn_w)
            publishBtn.addTarget(self, action: #selector(publishItemBtnClick(btn:)), for: .touchUpInside)
            publishBtn.setContent(image: IMAGE(btnInfo.image), title: btnInfo.title)
            publishBtn.tag = 500+index
            publishBtn.isUserInteractionEnabled = true
            scrollView.addSubview(publishBtn)
        }
        
        
        // pageControl
        pageControl.tintColor = UIColor.green
        pageControl.numberOfPages = dataItems!.count%8==0 ? dataItems!.count/8 : dataItems!.count/8+1
        pageControl.currentPage = 0
        pageControl.alpha = 0
        pageControl.pageIndicatorTintColor = UIColor.white
        pageControl.currentPageIndicatorTintColor = UIColor.orange
        pageControl.isUserInteractionEnabled = false
        bgView.addSubview(pageControl)
        pageControl.snp.makeConstraints { (make) in
            make.centerX.equalTo(bgView).offset(0)
            make.bottom.equalTo(bgView).offset(-50)
            make.width.equalTo(80)
            make.height.equalTo(30)
        }
        
    }

    
    func animationHanle(isShow: Bool, duration: Double, fromPoint: CGPoint, toPoint: CGPoint, target: UIView, keyName: String) {
        
        let basicAnimation = CAKeyframeAnimation(keyPath: "position")
        
        basicAnimation.values = [CGPoint.init(x: fromPoint.x, y: fromPoint.y), CGPoint.init(x: toPoint.x, y: isShow==true ? toPoint.y-20 : toPoint.y),  CGPoint.init(x: toPoint.x, y: toPoint.y)]
        basicAnimation.keyTimes = [NSNumber(floatLiteral: duration/3.0), NSNumber(floatLiteral:duration/3.0*2), NSNumber(floatLiteral:duration)]
        basicAnimation.duration = duration
        basicAnimation.delegate = self as CAAnimationDelegate
        basicAnimation.isRemovedOnCompletion = false
        basicAnimation.fillMode = kCAFillModeForwards
        
        target.layer.anchorPoint = CGPoint(x: 0, y: 0)
        target.layer.add(basicAnimation, forKey: keyName)
    }
    
    
    
    
    // MARK - publish
    
    func showPublishAlert() {
        
        var keyWindwow = UIApplication.shared.keyWindow
        if keyWindwow==nil {
            keyWindwow = UIApplication.shared.windows.first
        }
        keyWindwow?.addSubview(self)
        self.frame = (keyWindwow?.frame)! // 一定要记得更新self的frame
        
        // 透明变化的动画
        self.bgView.alpha = 0
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseOut, animations: {
            self.bgView.alpha = 1
            self.pageControl.alpha = 1
            self.closeBtn.transform = CGAffineTransform(rotationAngle: 0.0)
        }) { (Bool) in
            
        }
        
        
        // 按钮升起来的动画
        var index = 0
        for subView in self.scrollView.subviews {
            
            // isKind(of:)和is关键字效果是一样的
//            if subView.isKind(of: PublishBtn.self)
            if(subView is PublishBtn) {
                let publishBtn = subView as! PublishBtn
                let btn_x = index<8 ? 15+(self.btn_w+self.padding_x)*CGFloat(index%4) : Screen_Width+15+(self.btn_w+self.padding_x)*CGFloat((index-8)%4)
                let btn_y = index<8 ? 15+(self.btn_w+self.padding_x)*CGFloat(index/4) : 15+(self.btn_w+self.padding_x)*CGFloat((index-8)/4)
                
                DispatchQueue.main.asyncAfter(deadline: .now()+0.02*Double(index), execute: {
                    self.animationHanle(isShow: true, duration: 0.65, fromPoint: CGPoint.init(x: publishBtn.frame.origin.x, y: publishBtn.frame.origin.y), toPoint: CGPoint.init(x: btn_x, y: btn_y), target: publishBtn, keyName: "showAnimate")
                })
                
                
                DispatchQueue.main.asyncAfter(deadline: .now()+0.02*Double(dataItems!.count-1), execute: {
                    publishBtn.frame = CGRect(x: btn_x, y: btn_y, width: self.btn_w, height: self.btn_w)
                })
                index += 1
            }
        }
        


 
    }
    
    
    func hidePublishAlert() {
        
        // 按钮降落的动画
        var index = 0
        for subView in self.scrollView.subviews {
            if(subView is PublishBtn) {
                let publishBtn = subView as! PublishBtn
                let btn_x: CGFloat = index<8 ? 15+(self.btn_w+self.padding_x)*(CGFloat)(index%4) : Screen_Width+15+(self.btn_w+self.padding_x)*CGFloat((index-8)%4)
                let btn_y: CGFloat = index<8 ? 280+(self.btn_w+self.padding_x)*CGFloat(index/4) : 280+(self.btn_w+self.padding_x)*CGFloat((index-8)/4)
                
                DispatchQueue.main.asyncAfter(deadline: .now()+0.02*Double(dataItems!.count-1)-0.02*Double(index), execute: {
                    self.animationHanle(isShow: false, duration: 0.65, fromPoint: CGPoint.init(x: publishBtn.frame.origin.x, y: publishBtn.frame.origin.y), toPoint: CGPoint.init(x: btn_x, y: btn_y), target: publishBtn, keyName: "hideAnimate")
                })
 
                DispatchQueue.main.asyncAfter(deadline: .now()+0.02*Double(dataItems!.count-1), execute: {
                    publishBtn.frame = CGRect(x: btn_x, y: btn_y, width: self.btn_w, height: self.btn_w)
                })
                
                index += 1
            }
        }
        
        // 降落动画结束后，开始透明度动画
        UIView.animate(withDuration: 0.2, animations: { 
            self.closeBtn.transform = CGAffineTransform(rotationAngle: .pi/2)
            self.pageControl.alpha = 0
            
        }) { (Bool) in
            
            DispatchQueue.main.asyncAfter(deadline: .now()+0.02*Double(self.dataItems!.count), execute: {
                UIView.animate(withDuration: 0.2, animations: {
                    self.bgView.alpha = 0
                }, completion: { (Bool) in
                    self.removeFromSuperview()
                })
            });
 
        }
    
    }



    
    // MARK - touch
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        hidePublishAlert()

    }
    
    
    // MARK - scrollView delegate
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
         let offset_x = scrollView.contentOffset.x
        pageControl.currentPage = Int(offset_x/Screen_Width)
    }
    

        
}







// =================================== PublishBtn ===================================

class PublishBtn: UIControl {
    
    let imgV = UIImageView()
    let titleLab = UILabel()
    
    
    // MARK - init 
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        loadContentView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    private func loadContentView() {
        
        // imgV
        imgV.contentMode = .scaleAspectFill
        self.addSubview(imgV)
        imgV.snp.makeConstraints { (make) in
            make.top.equalTo(self).offset(0)
            make.centerX.equalTo(self.snp.centerX).offset(0)
            make.width.equalTo(55)
            make.height.equalTo(55)
        }
        
        
        // titleLab
        titleLab.textColor = UIColor.gray
        titleLab.font = FONT(12)
        titleLab.textAlignment = .center
        self.addSubview(titleLab)
        titleLab.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.snp.centerX).offset(0)
            make.bottom.equalTo(self).offset(0)
            make.height.equalTo(20)
        }
    }
    
    
    // 给publishBtn赋值
    func setContent(image: UIImage?, title: String?) {
        imgV.image = image
        titleLab.text = title
    }
    

  
}
    
