//
//  ConstantHeader.swift
//  WeiboSwiftWang66
//
//  Created by wang66 on 2017/6/8.
//  Copyright © 2017年 renmaituan. All rights reserved.
//

import UIKit

func FONT(_ size: CGFloat) -> UIFont{
    return UIFont.systemFont(ofSize: size)
}

func BFONT(_ size: CGFloat) ->UIFont {
    return UIFont.boldSystemFont(ofSize: size)
}

func IMAGE(_ name: String?) -> UIImage {
    if let imgName = name {
        return UIImage(named: imgName)!
    }
    return UIImage()
}

let Screen_Width = UIScreen.main.bounds.size.width

let Screen_Height = UIScreen.main.bounds.size.height


func ColorRGB(_ r: Float, _ g: Float, _ b:Float) -> UIColor {
    return UIColor.init(colorLiteralRed: r, green: g, blue: b, alpha: 1)
}

func ColorRGBA(_ r: Float, _ g:Float, _ b:Float, _ a:Float) -> UIColor {
    return UIColor.init(colorLiteralRed: r, green: g, blue: b, alpha: a)
}

func ColorHEX(_ hex: Int) -> UIColor {
    return UIColor.init(colorLiteralRed: ((Float)((hex & 0xFF0000) >> 16))/255.0, green: ((Float)((hex & 0xFF00) >> 8))/255.0, blue: ((Float)(hex & 0xFF))/255.0, alpha: 1)
}


//let ColorRandom = UIColor.init(colorLiteralRed: Float(arc4random_uniform(256))/255.0, green: Float(arc4random_uniform(256))/255.0, blue: Float(arc4random_uniform(256))/255.0, alpha: 1) // 为什么无效



let IOSVersion: String = UIDevice.current.systemVersion

//let IOSVersion_equal()

//func IOSVersion_equal(_ version: String) -> Bool {
//}









