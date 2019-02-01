//
//  UIColor+Extension.swift
//  BoneRichText
//
//  Created by 俞旭涛 on 2017/5/8.
//  Copyright © 2017年 俞旭涛. All rights reserved.
//

import UIKit

extension UIImage {
    /// 改变图片颜色
    ///
    /// - Parameter toColor: 改变颜色
    /// - Returns: 改变后的图片
    func color(to: UIColor) -> UIImage {
        let drawRect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        to.setFill()
        UIRectFill(drawRect)
        draw(in: drawRect, blendMode: .destinationIn, alpha: 1.0)
        let tintedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return tintedImage!
    }
}
