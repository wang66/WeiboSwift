//
//  PickMoneyView.swift
//  WeiboSwiftWang66
//
//  Created by 王亚文 on 2017/6/8.
//  Copyright © 2017年 renmaituan. All rights reserved.
//

import UIKit




class PickMoneyView: UIView, UITextFieldDelegate {

    // MARK - property
    var moneyItems = ["10", "20", "30", "40", "50", "100"]
    
    var textField: UITextField?
    
    var pickMoneyBlock: ((String)->Void)?
    
    var curMoney: String = ""
    
    
    
    // MARK - init and deinit
//    convenience init(items: [String]) {
//        moneyItems = items
//        self.init(frame: CGRect.zero)
//        
//    }
    
    convenience init() {
        self.init(frame: CGRect.zero)
        
    }

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        loadContentView()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    deinit {
        NotificationCenter.default.removeObserver(self) // 销毁通知
    }
    
    
    // MARK - init data and view
    
    func textFieldValueChanged(tf: UITextField) {
        curMoney = tf.text!
        self.callBackPickedMoney((textField?.text)!)
    }
    
    func textFieldValueChanged(notification: Notification) {
        let tf = notification.object as! UITextField
        curMoney = tf.text!.characters.count>0 ? tf.text! : "0"
        self.callBackPickedMoney(curMoney)
    }
    
    
    // 点击了金额按钮
    func moneyBtnClick(btn: UIButton) {
    
        resetTF() // 将输入框的内容清空重置
        resetMoneysBtns(index: btn.tag-500) // 刷新按钮的显示状态，正确的显示选中状态

        self.callBackPickedMoney(moneyItems[btn.tag-500])
    }
    
    
    
    func loadContentView() {
        
        // textfield
        textField = UITextField()
        textField?.font = UIFont.systemFont(ofSize: 13)
        textField?.delegate = self
        textField?.backgroundColor = ColorHEX(0xD8D8D8)
        textField?.keyboardType = .numberPad
        textField?.contentVerticalAlignment = .center
        textField?.borderStyle = .roundedRect
        textField?.attributedPlaceholder = NSAttributedString(string: "手动输入充值金额", attributes: [NSForegroundColorAttributeName:ColorHEX(0xFF805B), NSFontAttributeName:UIFont.systemFont(ofSize: 12)])
        NotificationCenter.default.addObserver(self, selector: #selector(textFieldValueChanged(notification:)), name: .UITextFieldTextDidChange, object: nil)
//        textField?.addTarget(self, action: #selector(textFieldValueChanged(tf:)), for: .valueChanged) // 用这种方法也可以 （更新：测试发现无效）
        self.addSubview(textField!)
        textField?.snp.makeConstraints({ (make) in
            make.left.equalTo(self).offset(15.0)
            make.right.equalTo(self).offset(-15.0)
            make.top.equalTo(self).offset(15.0)
            make.height.equalTo(30)
        })
        
        
        // money btns
        let centerXPadding = (UIScreen.main.bounds.size.width-3*80-15*2)/2;
        for index in 0..<moneyItems.count {
            let moneyBtn = UIButton()
            moneyBtn.frame = CGRect(x: 15.0+(80.0+centerXPadding)*CGFloat(index%3), y: 60.0+(35.0+15.0)*CGFloat(index/3), width: 80.0, height: 35.0)
            moneyBtn.setTitle(moneyItems[index], for: .normal)
            moneyBtn.setTitleColor(UIColor.orange, for: .normal)
            moneyBtn.setTitleColor(UIColor.white, for: .selected)
            moneyBtn.setBackgroundImage(UIImage(named:"user_reccharage_btn_normal"), for: .normal)
            moneyBtn.setBackgroundImage(UIImage(named:"user_reccharage_btn_selected"), for: .selected)
            moneyBtn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
            moneyBtn.tag = 500 + index
            moneyBtn.addTarget(self, action: #selector(moneyBtnClick(btn:)), for: .touchUpInside)
            self.addSubview(moneyBtn)
        }
        
    }
    
    
    // MARK - textfield delegate
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        resetMoneysBtns(index: -1)
        self.callBackPickedMoney(curMoney.characters.count>0 ? curMoney : "0")
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        resetMoneysBtns(index: -1)
        self.callBackPickedMoney(curMoney.characters.count>0 ? curMoney : "0")
    }
    
    
    // MARK - function method
    // index 为selected的按钮索引
    func resetMoneysBtns(index: Int) {
        
        var i: Int = 0
        for subView in self.subviews {
            if subView is UIButton { //
                let tempBtn = subView as! UIButton
                tempBtn.isSelected = false
                if i==index {
                    tempBtn.isSelected = true
                }
                i+=1
            }
        }
    }
    
    
    func resetTF() {
        textField?.resignFirstResponder()
        textField?.text = ""
        curMoney = ""
    }
    
    
    // 将选择的金额回调
    func callBackPickedMoney(_ money: String) {
        if let callback = pickMoneyBlock {
            callback(money)
        }
    }
    
    
    
    

}
