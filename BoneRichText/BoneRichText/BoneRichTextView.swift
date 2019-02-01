//
//  BoneRichTextView.swift
//  EasyPayStore
//
//  Created by 俞旭涛 on 2017/5/6.
//  Copyright © 2017年 俞旭涛. All rights reserved.
//

import UIKit

extension BoneRichTextView {
    
    /// 修改文本
    ///
    /// - Parameter range: 文本范围
    public func setText(range: NSRange, type: BoneMainView.KeyItemType) {
        let attributeStr = NSMutableAttributedString(attributedString: self.attributedText)
        let range = NSRange(location: range.location, length: range.length)
        switch type {
        case .bold:
            let font = self.textStyle.isBold ? UIFont.boldSystemFont(ofSize: self.textStyle.fontSize)
                : UIFont.systemFont(ofSize: self.textStyle.fontSize)
            attributeStr.addAttribute(kCTFontAttributeName as NSAttributedStringKey, value: font , range: range)
        case .color:
            attributeStr.addAttribute(NSAttributedStringKey.foregroundColor, value: self.textStyle.fontColor , range: range)
        case .font:
            let font = self.textStyle.isBold ? UIFont.boldSystemFont(ofSize: self.textStyle.fontSize)
                : UIFont.systemFont(ofSize: self.textStyle.fontSize)
            attributeStr.addAttribute(kCTFontAttributeName as NSAttributedStringKey, value: font , range: range)
        case .image: break
            
        }

        self.attributedText = attributeStr
    }

}

class BoneRichTextView: UITextView {

    var textStyle: BoneRichTextStyle!{
        didSet {
            let font = self.textStyle.isBold ? UIFont.boldSystemFont(ofSize: self.textStyle.fontSize)
                : UIFont.systemFont(ofSize: self.textStyle.fontSize)
            
            let attributes = [
                NSAttributedStringKey.font.rawValue: font,
                NSAttributedStringKey.foregroundColor.rawValue: self.textStyle.fontColor
                ] as [String : Any]
            
            self.typingAttributes = attributes
        }
    }
    
    var htmlString: String {
        get {
            return self.attributedText.html()
        }
        set {
            self.attributedText = newValue.attributedString()
        }
    }
    
    /// 最后选定的范围
    var lastSelectedRange: NSRange {
        get {
            return self.lastRange
        }
    }

    // 将图片插入到富文本中
    var setImage: UIImage? {
        didSet {
            if let image = self.setImage {
                let attach = NSTextAttachment()
                attach.image = setImage
                let imageRate = image.size.width / image.size.height
                attach.bounds = CGRect(x: 0, y: 10, width: self.width - 15, height: (self.width - 15) / imageRate)
                let imageAttr = NSAttributedString(attachment: attach)
                let mutableAttr = NSMutableAttributedString(attributedString: self.attributedText)
                mutableAttr.insert(imageAttr, at: self.selectedRange.location)
                let rowRate = NSAttributedString(string: "\n")
                mutableAttr.insert(rowRate, at: self.selectedRange.location + rowRate.length)
                //再次记住新的光标的位置
                let newSelectedRange = NSMakeRange(self.selectedRange.location + rowRate.length, 0)
                self.attributedText = mutableAttr
                self.selectedRange = newSelectedRange
            }
        }
    }
    
    // 待用：图片 html 重组方法
    func change(_ str: String) -> String? {
        let marr = str.components(separatedBy: "\"")
        
        let newArr = marr.flatMap { htmlString -> [String] in
            var newArr = Array<Any>()
            let aBool = !htmlString.hasPrefix("file:///Attachment")
            if aBool {
                newArr.append(htmlString)
            } else {
                // 这里将上传成功的图片 URL 插入
                newArr.append("http://og1yl0w9z.bkt.clouddn.com/18-7-25/6373094.jpg")
            }
            return newArr as! [String]
        }
        
        let newStr = newArr.joined(separator: "\"")
        
        return newStr
    }

    fileprivate var lastRange: NSRange!
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        self.delegate = self
        self.lastRange = self.selectedRange
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension BoneRichTextView: UITextViewDelegate {
    
    // 在text view获得焦点之前会调用
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        return true
    }
    
    func textViewDidChange(_ textView: UITextView) {
        let font = self.textStyle.isBold ? UIFont.boldSystemFont(ofSize: self.textStyle.fontSize)
            : UIFont.systemFont(ofSize: self.textStyle.fontSize)

        let attributes = [
            NSAttributedStringKey.font.rawValue: font,
            NSAttributedStringKey.foregroundColor.rawValue: self.textStyle.fontColor
            ] as [String : Any]
        
        self.typingAttributes = attributes
    }
    
    // 当用户选择text view中的部分内容
    func textViewDidChangeSelection(_ textView: UITextView) {
        self.lastRange = self.selectedRange
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        return true
    }
}
