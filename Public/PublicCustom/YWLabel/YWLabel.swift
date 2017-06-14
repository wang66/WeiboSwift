//
//  YWLabel.swift
//  WeiboSwiftWang66
//
//  Created by wang66 on 2017/6/8.
//  Copyright © 2017年 renmaituan. All rights reserved.
//

import UIKit

class YWLabel: UILabel {

    
    // MARK - init
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.white
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    /// 使UILable显示有行间距的文本
    ///
    /// - Parameters:
    ///   - text: 文本字符串
    ///   - lineSpacing: 行间距
    func labelText(text: String, lineSpacing: CGFloat) {
        
        if lineSpacing==0 {
            self.text = text
            return
        }
        
        let paraStype = NSMutableParagraphStyle()
        paraStype.lineSpacing = lineSpacing
        let attributesDict: [String:Any] = [NSParagraphStyleAttributeName: paraStype, NSForegroundColorAttributeName: self.textColor, NSFontAttributeName: self.font]
        let attrStr = NSAttributedString(string: text, attributes: attributesDict)
        
        self.attributedText = attrStr
    }
    
    
    
    /// 由一串文本、文本颜色、文本字体生成一个富文本NSAttributedString
    ///
    /// - Parameters:
    ///   - texts: 一串文本
    ///   - textColors: 一串文本相应的字体颜色
    ///   - textFonts: 一串文本相应的字体大小
    /// - Returns: 富文本NSAttributedString
    class func attributedTexts(texts: [String], textColors: [UIColor], textFonts: [UIFont]) -> NSAttributedString? {
        
        if texts.count == 0 {
            return nil
        }
        
        let resultAttrStr = NSMutableAttributedString()
        
        for index in 0..<texts.count  {
            let text = texts[index]
            let eachAttrStr = NSAttributedString(string: text, attributes: [NSForegroundColorAttributeName: textColors[index], NSFontAttributeName: textFonts[index]])
            resultAttrStr.append(eachAttrStr)
        }
        
        return resultAttrStr
    }
    
    
    
    /// 由一串文本、文本颜色、文本字体，外加行间距，生成一个富文本NSAttributedString
    ///
    /// - Parameters:
    ///   - texts: 一串文本
    ///   - textColors: 一串文本相应的字体颜色
    ///   - textFonts: 一串文本相应的字体大小
    ///   - lineSpacing: 行间距
    /// - Returns: 富文本NSAttributedString
    class func attributedTexts(texts: [String], textColors: [UIColor], textFonts: [UIFont], lineSpacing: CGFloat) -> NSAttributedString {
        
        let paraStype = NSMutableParagraphStyle()
        paraStype.lineSpacing = lineSpacing
        let mAttrStr = YWLabel.attributedTexts(texts: texts, textColors: textColors, textFonts: textFonts)?.mutableCopy() as! NSMutableAttributedString
        mAttrStr.addAttribute(NSParagraphStyleAttributeName, value: paraStype, range: NSRange.init(location: 0, length: mAttrStr.length))
        
        return mAttrStr
    }
    
    
    
    /// 传入label的宽度和attributedStr，以此计算label文本所占的实际大小
    ///
    /// - Parameters:
    ///   - width: 该label的宽度
    ///   - attributedStr: 一个attributedStr
    /// - Returns: 该label文本所占的实际大小
    class func sizeLabelWith(width: CGFloat, attributedStr: NSAttributedString) -> CGSize {
        
        if width == 0.0 {
            return CGSize.zero
        }
        
        let tempLab = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: 1000))
        tempLab.attributedText = attributedStr
        tempLab.numberOfLines = 0
        let labSize = tempLab.sizeThatFits(tempLab.bounds.size)
        
        return labSize
    }
    
    
    
    /// 传入label的width、text、font，以此计算label文本所占的实际大小
    ///
    /// - Parameters:
    ///   - width: 该label的宽度
    ///   - text: 该label的文本
    ///   - font: 该label的字体
    /// - Returns: 该label文本所占的实际大小
    class func sizeLabelWith(width: CGFloat, text: String, font: UIFont) -> CGSize{
        
        if width == 0.0 {
            return CGSize.zero
        }
        
        let tempLab = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: 1000))
        tempLab.text = text
        tempLab.font = font
        tempLab.numberOfLines = 0
        let labSize = tempLab.sizeThatFits(tempLab.bounds.size)
        
        return labSize
    }
    
    
    
    /// 同上个方法，只不过多了个lineSpacing参数
    ///
    /// - Parameters:
    ///   - width: width description
    ///   - text: text description
    ///   - font: font description
    ///   - lineSpacing: lineSpacing description
    /// - Returns: return value description
    class func sizeLabelWith(width: CGFloat, text: String, font: UIFont, lineSpacing: CGFloat) -> CGSize {
        
        if width == 0.0 || text.characters.count == 0 {
            return CGSize.zero
        }
        let paraStype = NSMutableParagraphStyle()
        paraStype.lineSpacing = lineSpacing
        
        let attrStr = NSAttributedString(string: text, attributes: [NSFontAttributeName: font, NSParagraphStyleAttributeName: paraStype])
        
        let tempLab = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: 1000))
        tempLab.numberOfLines = 0
        tempLab.attributedText = attrStr
        let labSize = tempLab.sizeThatFits(tempLab.bounds.size)
        
        return labSize
    }
}

