//
//  BoneKeyBoardView.swift
//  keyBoardPopUp
//
//  Created by 俞旭涛 on 2017/5/2.
//  Copyright © 2017年 Huangjunwei. All rights reserved.
//

import UIKit

protocol BoneRichToolsDelegate: NSObjectProtocol {
    
    
    /// 操作richTools改变前
    ///
    /// - Parameters:
    ///   - richTools: <#richTools description#>
    ///   - type: <#type description#>
    ///   - textStyle: <#textStyle description#>
    func richText(richTools: BoneRichTools, type: BoneMainView.KeyItemType, beginDidChange textStyle: BoneRichTextStyle)
    
    /// 操作richTools改变后
    ///
    /// - Parameters:
    ///   - richTools: <#richTools description#>
    ///   - type: <#type description#>
    ///   - textStyle: <#textStyle description#>
    func richText(richTools: BoneRichTools, type: BoneMainView.KeyItemType, endDidChange textStyle: BoneRichTextStyle)
    
    /// 监控richTools位置变化
    ///
    /// - Parameters:
    ///   - richTools: richTools description
    ///   - form: 位置变化
    func richText(richTools: BoneRichTools, affineTransform form: CGAffineTransform)
}



class BoneRichTools: UIView {
    
    public var textStyle: BoneRichTextStyle {
        get {
            let model = BoneRichTextStyle()
            model.fontColor = self.colorView.getColor
            model.isBold = self.mainView.isBold
            model.fontSize = self.fontView.getFontSize
            return model
        }
    }
    
    public var delegate: BoneRichToolsDelegate?

    private var hiddenBtn: UIButton!  // 隐藏键盘
    
    convenience init() {
        self.init(frame: CGRect(x: 0, y: screen_height - 44, width: screen_width, height: 44))

        NotificationCenter.default.addObserver(self, selector:#selector(BoneRichTools.keyBoardWillShow(_:)), name:NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector:#selector(BoneRichTools.keyBoardWillHide(_:)), name:NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        self.layer.masksToBounds = true
        self.backgroundColor = UIColor.white
        
        self.addSubview(self.scrollView)

        self.addSubview(self.closeBtn)
        
        self.scrollView.addSubview(self.mainView)
        self.scrollView.addSubview(self.colorView)
        self.scrollView.addSubview(self.fontView)
        
        let line = UIView(frame: CGRect(x: 0, y: 0, width: screen_width, height: 0.5))
        line.backgroundColor = UIColor.lightGray
        self.addSubview(line)
    }
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: screen_width - BoneRichConfig.hiddenWidth, height: self.height))
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.delegate = self
        return scrollView
    }()
    
    /// 主体功能块
    lazy var mainView: BoneMainView = {
        let mainView = BoneMainView()
        mainView.mainAction { (type) in
            self.swiftAction(isShow: true, type: type)
        }
        return mainView
    }()
    
    /// 字号块
    lazy var fontView: BoneFontView = {
        let fontView = BoneFontView()
        fontView.showAction(cellback: { (isShow) in
            if !isShow {
                self.swiftAction(isShow: isShow, type: .font)
            }
        })
        return fontView
    }()
    
    /// 颜色块
    lazy var colorView: BoneColorView = {
        let colorView = BoneColorView()
        colorView.showAction(cellback: { (isShow) in
            if !isShow {
                self.swiftAction(isShow: isShow, type: .color)
            }
        })
        return colorView
    }()
    
    
    /// 切换事件
    ///
    /// - Parameters:
    ///   - isShow: 是否显示
    ///   - type: 按钮类型
    private func swiftAction(isShow: Bool, type: BoneMainView.KeyItemType) {
        if isShow {
            switch type {
            case .image:
                break
            case .font:
                self.mainView.isHidden = true
                self.closeBtn.type = .close
                self.fontView.isShow = true
                self.scrollView.contentSize.width = self.fontView.width
                
            case .bold: break
            case .color:
                self.mainView.isHidden = true
                self.closeBtn.type = .close
                self.colorView.isShow = true
                self.scrollView.contentSize.width = self.colorView.width
            }
            self.delegate?.richText(richTools: self, type: type, beginDidChange: self.textStyle)
        } else {
            self.mainView.isHidden = false
            self.scrollView.contentSize.width = self.mainView.width
            self.closeBtn.type = .editing
            self.mainView.btnColor = colorView.getColor
            self.delegate?.richText(richTools: self, type: type, endDidChange: self.textStyle)
        }
        
        
    }
    
    /// 关闭按钮
    lazy var closeBtn: BoneCloseBtn = {
        let closeBtn = BoneCloseBtn()
        closeBtn.close {
            self.colorView.isShow = false
            self.fontView.isShow = false
            closeBtn.type = .editing
        }
        return closeBtn
    }()

    /// 监视键盘显示
    ///
    /// - Parameter note: note description
    @objc private func keyBoardWillShow(_ note:Notification) {
        let userInfo  = note.userInfo
        let keyBoardBounds = (userInfo?[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let duration = (userInfo?[UIKeyboardAnimationDurationUserInfoKey] as! NSNumber).doubleValue
        
        self.convert(keyBoardBounds, to:nil)
        let deltaY = keyBoardBounds.height
        let animations:(() -> Void) = {
            self.transform = CGAffineTransform(translationX: 0,y: -deltaY)
            self.delegate?.richText(richTools: self, affineTransform: self.transform)
        }
        if duration > 0 {
            let options = UIViewAnimationOptions(rawValue: UInt((userInfo?[UIKeyboardAnimationCurveUserInfoKey] as! NSNumber).intValue << 16))
            
            UIView.animate(withDuration: duration, delay: 0, options:options, animations: animations, completion: nil)
            
        } else {
            animations()
        }
    }
    
    
    /// 监视键盘隐藏
    ///
    /// - Parameter note: <#note description#>
    @objc private func keyBoardWillHide(_ note: Notification) {
        let userInfo  = note.userInfo
        let duration = (userInfo?[UIKeyboardAnimationDurationUserInfoKey] as! NSNumber).doubleValue

        let animations:(() -> Void) = {
            self.transform = CGAffineTransform.identity
            self.delegate?.richText(richTools: self, affineTransform: self.transform)
        }
        if duration > 0 {
            let options = UIViewAnimationOptions(rawValue: UInt((userInfo?[UIKeyboardAnimationCurveUserInfoKey] as! NSNumber).intValue << 16))
            UIView.animate(withDuration: duration, delay: 0, options:options, animations: animations, completion: nil)
            
        } else {
            animations()
        }
    }
    
    
    // 销毁
    deinit {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
}


extension BoneRichTools: UIScrollViewDelegate {
    
    // 滚动触发
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        if scrollView.contentOffset.x < -50 {
            self.colorView.isShow = false
            self.fontView.isShow = false
        }
        
    }
}
