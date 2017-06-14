//
//  MineListCell.swift
//  WeiboSwiftWang66
//
//  Created by wang66 on 2017/6/14.
//  Copyright © 2017年 renmaituan. All rights reserved.
//

import UIKit

class MineListCell: UITableViewCell {
    
    let imgView = UIImageView()
    let titleLab = UILabel()
    

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        accessoryType = .disclosureIndicator
        loadContentView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func clearCellData() {
        titleLab.attributedText = nil
    }
    
    func loadContentView() {
        
        // imgView
        imgView.contentMode = .scaleAspectFit
        imgView.sizeToFit()
        addSubview(imgView)
        imgView.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(10)
            make.centerY.equalTo(self).offset(0)
            make.width.equalTo(25)
            make.height.equalTo(25)
        }
        
        
        // titleLab
        titleLab.textAlignment = .left
        addSubview(titleLab)
        titleLab.snp.makeConstraints { (make) in
            make.left.equalTo(imgView.snp.right).offset(10)
            make.right.equalTo(self).offset(-10)
            make.centerY.equalTo(self).offset(0)
        }
        
        // lineV
        let lineV = UIView()
        lineV.backgroundColor = UIColor.lightGray
        addSubview(lineV)
        lineV.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(0)
            make.right.equalTo(self).offset(0)
            make.bottom.equalTo(self).offset(0)
            make.height.equalTo(0.3)
        }
    }
    
    func refreshContent(model: MineListModel) {
        clearCellData()
        imgView.image = model.iconImg
        titleLab.attributedText = YWLabel.attributedTexts(texts: [model.listTitle!, model.listSubTitle!], textColors: [UIColor.black, UIColor.gray], textFonts: [FONT(14), FONT(12)])
    }
    

}
