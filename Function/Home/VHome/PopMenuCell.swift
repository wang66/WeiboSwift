//
//  PopMenuCell.swift
//  WeiboSwiftWang66
//
//  Created by 王亚文 on 2017/6/7.
//  Copyright © 2017年 renmaituan. All rights reserved.
//

import UIKit

class PopMenuCell: UITableViewCell {
    
    var imgV: UIImageView?
    var titlelab: UILabel?

    
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        loadContentView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func loadContentView() {
        
        backgroundColor = UIColor.clear
        
        imgV = UIImageView()
        self.addSubview(imgV!)
        imgV?.snp.makeConstraints({ (make) in
            make.left.equalTo(self).offset(5)
            make.centerY.equalTo(self).offset(0)
            make.width.equalTo(20)
            make.height.equalTo(20)
        })
        
        titlelab = UILabel()
        titlelab?.font = UIFont.systemFont(ofSize: 13)
        titlelab?.textColor = UIColor.white
        self.addSubview(titlelab!)
        titlelab?.snp.makeConstraints({ (make) in
            make.left.equalTo((imgV?.snp.right)!).offset(5)
            make.right.equalTo(self.snp.right).offset(-10)
            make.centerY.equalTo(self)
        })
        
        
    }
    
    
    public func refreshContent(content: (icon:String, title:String)) {
        imgV?.image = IMAGE(content.icon)
        titlelab?.text = content.title
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
