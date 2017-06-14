//
//  UserInfoCell.swift
//  WeiboSwiftWang66
//
//  Created by 王亚文 on 2017/6/14.
//  Copyright © 2017年 renmaituan. All rights reserved.
//

import UIKit

class UserInfoCell: UITableViewCell {
    
    let imgView = UIImageView()
    let nameDescLab = UILabel()
    let weiboCountLab = UILabel()
    let followLab = UILabel()
    let fansLab = UILabel()
    
    

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        loadContentView()
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func loadContentView() {
        
        // imgView
        imgView.layer.cornerRadius = 25.0
        imgView.layer.masksToBounds = true
        imgView.contentMode = .scaleAspectFit
        addSubview(imgView)
        imgView.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(15)
            make.top.equalTo(self).offset(15)
            make.width.equalTo(50)
            make.height.equalTo(50)
        }
        
        // nameDescLab
        nameDescLab.numberOfLines = 0
        addSubview(nameDescLab)
        nameDescLab.snp.makeConstraints { (make) in
            make.left.equalTo(imgView.snp.right).offset(15)
            make.right.equalTo(self).offset(-15)
            make.centerY.equalTo(imgView).offset(0)
        }
        
        
        // lineV
        let lineV = UIView()
        lineV.backgroundColor = UIColor.lightGray
        addSubview(lineV)
        lineV.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(0)
            make.right.equalTo(self).offset(0)
            make.top.equalTo(imgView.snp.bottom).offset(15)
            make.height.equalTo(0.4)
        }
        
        
        // weiboCountLab
        weiboCountLab.textAlignment = .center
        weiboCountLab.numberOfLines = 0
//        weiboCountLab.backgroundColor = UIColor.purple
        addSubview(weiboCountLab)
        weiboCountLab.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(0)
            make.top.equalTo(lineV.snp.bottom).offset(0)
            make.bottom.equalTo(self).offset(0)
            make.width.equalTo(Screen_Width/3.0)
        }
        
        // followLab
        followLab.textAlignment = .center
        followLab.numberOfLines = 0
//        followLab.backgroundColor = UIColor.green
        addSubview(followLab)
        followLab.snp.makeConstraints { (make) in
            make.left.equalTo(weiboCountLab.snp.right).offset(0)
            make.top.equalTo(lineV.snp.bottom).offset(0)
            make.bottom.equalTo(self).offset(0)
            make.width.equalTo(Screen_Width/3.0)
        }
        
        // fansLab
        fansLab.textAlignment = .center
        fansLab.numberOfLines = 0
//        fansLab.backgroundColor = UIColor.yellow
        addSubview(fansLab)
        fansLab.snp.makeConstraints { (make) in
            make.left.equalTo(followLab.snp.right).offset(0)
            make.top.equalTo(lineV.snp.bottom).offset(0)
            make.bottom.equalTo(self).offset(0)
            make.width.equalTo(Screen_Width/3.0)
        }
        
    }
    
    
    func refreshContent(userInfo: UserInfoModel) {
        imgView.image = IMAGE("tabbar_compose_miaopai_neo")
        nameDescLab.attributedText = YWLabel.attributedTexts(texts: ["\(userInfo.nickname!)\n",userInfo.desc!], textColors: [UIColor.black, UIColor.lightGray], textFonts: [BFONT(12), FONT(12)], lineSpacing: 4)
        weiboCountLab.attributedText = YWLabel.attributedTexts(texts: ["\(userInfo.weiboCount!)", "\n微博"], textColors: [UIColor.black, UIColor.lightGray], textFonts: [BFONT(12), FONT(12)], lineSpacing: 3.0)
        followLab.attributedText = YWLabel.attributedTexts(texts: ["\(userInfo.followCount!)", "\n关注"], textColors: [UIColor.black, UIColor.lightGray], textFonts: [BFONT(12), FONT(12)], lineSpacing: 3.0)
        fansLab.attributedText = YWLabel.attributedTexts(texts: ["\(userInfo.fansCount!)", "\n粉丝"], textColors: [UIColor.black, UIColor.lightGray], textFonts: [BFONT(12), FONT(12)], lineSpacing: 3.0)
        weiboCountLab.textAlignment = .center
        followLab.textAlignment = .center
        fansLab.textAlignment = .center
    }

}
