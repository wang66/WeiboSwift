//
//  HomeDetailViewController.swift
//  WeiboSwiftWang66
//
//  Created by 王亚文 on 2017/6/7.
//  Copyright © 2017年 renmaituan. All rights reserved.
//

import UIKit

class HomeDetailViewController: BasicViewController {

    
    var topTipBtn: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "充值"
        loadContentView()
        
    }
    
    
    func rechargetBtnClick(btn: UIButton) {
        
        // 这里应该先判断要支付的金额是否大于0，若等于0，则提示不能支付
//        if (Int)btn.titleLabel?.text > 0 {
//            actionSheet.show()
//        }
        view.endEditing(true)
        
        actionSheet.show()
        
        
    }
    
    
    func loadContentView() {

        self.view.backgroundColor = ColorHEX(0xEEEEEE)
        
        topTipBtn = UIButton()
        topTipBtn.setTitle(" 充值需要消费50%-100%，奖金提款无限制", for: .normal)
        topTipBtn.setTitleColor(UIColor.red, for: .normal)
        topTipBtn.setImage(UIImage(named:"user_recharge_warn"), for: .normal)
        topTipBtn.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        topTipBtn.backgroundColor = ColorHEX(0xFFF4CE)
        topTipBtn.isUserInteractionEnabled = false
        self.view.addSubview(topTipBtn)
        topTipBtn.snp.makeConstraints { (make) in
            make.left.equalTo(self.view).offset(0)
            make.right.equalTo(self.view).offset(0)
            make.top.equalTo(self.view).offset(0)
            make.height.equalTo(35)
        }
        
        
        let pickMoneyV = PickMoneyView()
        pickMoneyV.backgroundColor = UIColor.white
        self.view.addSubview(pickMoneyV)
        pickMoneyV.snp.makeConstraints { (make) in
            make.left.equalTo(self.view).offset(0)
            make.right.equalTo(self.view).offset(0)
            make.top.equalTo(topTipBtn.snp.bottom).offset(20)
            make.height.equalTo(160)
        }
        
        
        
        
        let rechargeBtn = UIButton()
        rechargeBtn.setTitle("去充值\(0)元", for: .normal)
        rechargeBtn.setTitleColor(UIColor.white, for: .normal)
        rechargeBtn.backgroundColor = ColorHEX(0xFC5638)
        rechargeBtn.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        rechargeBtn.layer.cornerRadius = 4.0
        rechargeBtn.layer.masksToBounds = true
        rechargeBtn.addTarget(self, action: #selector(rechargetBtnClick(btn:)), for: .touchUpInside)
        self.view.addSubview(rechargeBtn)
        rechargeBtn.snp.makeConstraints { (make) in
            make.left.equalTo(self.view).offset(15)
            make.right.equalTo(self.view).offset(-15)
            make.top.equalTo(pickMoneyV.snp.bottom).offset(80)
            make.height.equalTo(40)
        }
        
        
        pickMoneyV.pickMoneyBlock = {(money: String)->Void in
            rechargeBtn.setTitle("去充值\(money)元", for: .normal)
        }
        
        
        let bottomTipLab = UILabel()
        bottomTipLab.font = UIFont.systemFont(ofSize: 13)
        bottomTipLab.text = "点击充值，即表示您已同意《充值协议》"
        bottomTipLab.textColor = UIColor.gray
        bottomTipLab.textAlignment = .center
        self.view.addSubview(bottomTipLab)
        bottomTipLab.snp.makeConstraints { (make) in
            make.left.equalTo(self.view).offset(15)
            make.right.equalTo(self.view).offset(-15)
            make.top.equalTo(rechargeBtn.snp.bottom).offset(5)
            make.height.equalTo(30)
        }

    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        actionSheet.hide()
    }
    
    
    
    // MARK - lazy
    lazy var actionSheet: YWActionSheet = {
        
        let weixinPay = PayTypeModel(iconName: "weixinPay", title: "微信")
        let aliPay = PayTypeModel(iconName: "aliPay", title: "支付宝")
        let unionPay = PayTypeModel(iconName: "unionPay", title: "银联")
        let actionSheet = YWActionSheet(items: [weixinPay, aliPay, unionPay])
        actionSheet.selectedPayTypeBlock = { (payModel: PayTypeModel) -> Void in
            
            let alert = UIAlertView(title: "", message: "你选择了\(payModel.title!)支付", delegate: self, cancelButtonTitle: "取消")
            alert.show()
        }
        return actionSheet
    }()
    

    
    
}
