//
//  BoneTools.swift
//  YichuanCRM
//
//  Created by 俞旭涛 on 2017/3/25.
//  Copyright © 2017年 俞旭涛. All rights reserved.
//

import UIKit

struct BoneTools {
    private let appId = "1209703132"    // 项目ID
    static var shared = BoneTools()

    /// iphone尺寸
    struct iPhone {
        // iPhone5/5c/5s/SE 4英寸 屏幕宽高：320*568点 屏幕模式：2x 分辨率：1136*640像素
        static var iPhone5: Bool {
            return UIScreen.main.bounds.size.height == 568.0
        }
        // iPhone6/6s/7 4.7英寸 屏幕宽高：375*667点 屏幕模式：2x 分辨率：1334*750像素
        static var iPhone6: Bool {
            return UIScreen.main.bounds.size.height == 667.0
        }
        // iPhone6 Plus/6s Plus/7 Plus 5.5英寸 屏幕宽高：414*736点 屏幕模式：3x 分辨率：1920*1080像素
        static var iPhone6P: Bool {
            return UIScreen.main.bounds.size.height == 736.0
        }
    }
    
    /// 状态栏加载
    ///
    /// - Parameter open: 是否打开
    public func statusBarLoad(open: Bool) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    /// 转换class获取参数
    ///
    /// - Parameter anyClass: 需要传的参数(必须要class类型)
    /// - Returns: 字典类型参数
    public func getParam(anyClass: Any) -> [String: Any]? {
        let mirror = Mirror(reflecting: anyClass)
        var param = [String: Any]()
        for (key, value) in mirror.children {
            param.updateValue(value, forKey: key!)
        }
        return param
    }
    
    //todo
    /// 根据class名称，获取class
    ///
    /// - Parameter className: class名称
    /// - Returns: class
    public func getClass(className: String) -> AnyClass? {
        if  let appName: String = Bundle.main.object(forInfoDictionaryKey: "CFBundleName") as! String? {
            let classStringName = "\(appName).\(className)"
            return NSClassFromString(classStringName)
        }
        return nil
    }
    
    /// 状态栏样式
    ///
    /// - Parameter style: `default`黑色 / lightContent白色
    public func statusBar(style: UIStatusBarStyle) {
        UIApplication.shared.statusBarStyle = style
    }
    
    /// 求和方法
    ///
    /// - Parameter to: 需要相加的数值
    /// - Returns: 返回所有to总数
    public func sum(to: Double...) -> Double {
        return to.reduce(0,{ $0 + $1 })
    }

    // 获取版本
    public func getVersion() -> String {
        return Bundle.main.infoDictionary!["CFBundleShortVersionString"] as! String
    }

    /// 16进制颜色值转换为UIColor
    ///
    /// - Parameters:
    ///   - code: 16进制颜色值
    ///   - alpha: 透明度
    /// - Returns: 返回颜色
    public func checkColor(code: String, alpha: CGFloat = 1) -> UIColor {
        var cString: String = code.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines)
        
        if cString.characters.count < 6 {return UIColor.black}
        if cString.hasPrefix("0X") {cString = cString.substring(from: cString.index(cString.startIndex, offsetBy: 2))}
        if cString.hasPrefix("#") {cString = cString.substring(from: cString.index(cString.startIndex, offsetBy: 1))}
        if cString.characters.count != 6 {return UIColor.black}
        var range: NSRange = NSMakeRange(0, 2)
        let rString = (cString as NSString).substring(with: range)
        range.location = 2
        let gString = (cString as NSString).substring(with: range)
        range.location = 4
        let bString = (cString as NSString).substring(with: range)
        var r: UInt32 = 0x0
        var g: UInt32 = 0x0
        var b: UInt32 = 0x0
        Scanner.init(string: rString).scanHexInt32(&r)
        Scanner.init(string: gString).scanHexInt32(&g)
        Scanner.init(string: bString).scanHexInt32(&b)
        
        return UIColor(red: CGFloat(r)/255.0, green: CGFloat(g)/255.0, blue: CGFloat(b)/255.0, alpha: alpha)
    }
    
    
    /// 获取文字高度
    ///
    /// - Parameters:
    ///   - text: 文字
    ///   - font: 字号
    ///   - width: 宽度
    /// - Returns: 返回高度
    public func getTextHeigh(text: String, font: UIFont, width: CGFloat) -> CGFloat {
        let size = CGSize(width: width, height: 1000)
        let dic = NSDictionary(object: font, forKey: NSFontAttributeName as NSCopying)
        let stringSize = text.boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: dic as? [String : AnyObject], context:nil).size
        return stringSize.height
    }
    
    
    /// 获取文字宽度
    ///
    /// - Parameters:
    ///   - text: 文字内容
    ///   - font: 字号
    ///   - height: 宽度
    /// - Returns: 返回高度
    public func getTextWidth(text: String,font: UIFont, height: CGFloat) -> CGFloat {
        let size = CGSize(width: 1000, height: height)
        let dic = NSDictionary(object: font, forKey: NSFontAttributeName as NSCopying)
        let stringSize = text.boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: dic as? [String : AnyObject], context:nil).size
        return stringSize.width
    }
    

}

