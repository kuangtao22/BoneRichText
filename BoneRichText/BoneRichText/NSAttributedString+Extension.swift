//
//  NSAttributedString.swift
//  EasyPayStore
//
//  Created by 俞旭涛 on 2017/5/6.
//  Copyright © 2017年 俞旭涛. All rights reserved.
//

import UIKit

extension NSAttributedString {
    
    /// 转超文本格式(Html)
    ///
    /// - Returns: Html String
    func html() -> String {
        let exportParams = [NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType,
                            NSCharacterEncodingDocumentAttribute:String.Encoding.utf8.rawValue] as [String : Any]
        
        do {
            let htmlData = try self.data(from: NSMakeRange(0, self.length), documentAttributes: exportParams)
            let htmlString = NSString.init(data: htmlData, encoding: String.Encoding.utf8.rawValue)
            return htmlString as! String
        } catch let error as NSError {
            print(error.localizedDescription)
            return ""
        }
    }
    
    
}


extension String {
    /// html转富文本格式
    ///
    /// - Returns: 富文本格式
    func attributedString() -> NSAttributedString? {
        do {
            let attrStr = try NSAttributedString(data: self.data(using: String.Encoding.unicode, allowLossyConversion: true)!, options: [NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType], documentAttributes: nil)
            return attrStr
            
        } catch let error as NSError {
            print(error.localizedDescription)
            return nil
        }
    }
}
