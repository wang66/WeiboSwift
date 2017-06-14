//
//  WeiboCell.swift
//  WeiboSwiftWang66
//
//  Created by wang66 on 2017/6/6.
//  Copyright © 2017年 renmaituan. All rights reserved.
//

import UIKit

class WeiboModel: NSObject {
    var contentStr: String?
    var image: UIImage?
    
    
}

class WeiboCell: UITableViewCell {
    

    var contentLab: UILabel?
    var imgV: UIImageView?
    

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        loadContent()

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func loadContent() {
        
        
        backgroundColor = UIColor.white
        
        imgV = UIImageView()
        addSubview(imgV!)
        
        
        contentLab = UILabel()
        contentLab?.textColor = UIColor.purple
        contentLab?.font = UIFont.systemFont(ofSize: 13)
        contentLab?.textAlignment = .left
        contentLab?.numberOfLines = 0
        contentLab?.backgroundColor = UIColor.white
        addSubview(contentLab!)
        
        
        imgV?.snp.makeConstraints({ (make) in
            make.left.equalTo(self).offset(15)
            make.centerY.equalTo(self)
            make.width.equalTo(40)
            make.height.equalTo(40)
        })
        
        contentLab?.snp.makeConstraints({ (make) in
            make.left.equalTo((imgV?.snp.right)!).offset(10)
            make.right.equalTo(self.snp.right).offset(-10)
            make.centerY.equalTo(self)
        })
        
        let line = UIView()
        line.backgroundColor = ColorRGB(207.0, 240.0, 244.0) // 为什么定义的RGB方法无效
        addSubview(line)
        line.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(0)
            make.right.equalTo(self).offset(0)
            make.bottom.equalTo(self).offset(0)
            make.height.equalTo(0.5)
        }
        
        
    }
    
    
    
    func refreshContent(model: WeiboModel) {
        contentLab?.text = model.contentStr
        imgV?.image = model.image
    }
    

    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
