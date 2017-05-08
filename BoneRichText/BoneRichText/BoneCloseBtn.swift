//
//  BoneCloseBtn.swift
//  keyBoardPopUp
//
//  Created by 俞旭涛 on 2017/5/5.
//  Copyright © 2017年 Huangjunwei. All rights reserved.
//

import UIKit

extension BoneCloseBtn {
    
    public func close(cellback: @escaping TouchUpInside) {
        self.onClick = cellback
    }
}

class BoneCloseBtn: UIButton {
    
    enum BtnType {
        case close
        case editing
    }
    
    var type: BtnType {
        get {
            if self.imageView?.image == self.closeIcon {
                return .close
            }
            return .editing
        }
        set {
            switch newValue {
            case .close:
                self.setImage(self.closeIcon, for: UIControlState.normal)
            case .editing:
                self.setImage(self.keyBoardIcon, for: UIControlState.normal)
            }
        }
    }
    
    var getWidth: CGFloat {
        get {
            return BoneRichConfig.closeWidth
        }
    }
    
    private let closeIcon = UIImage(named: "BoneIcon.bundle/icon_close")
    private let keyBoardIcon = UIImage(named: "BoneIcon.bundle/icon_keyBoard")
    
    fileprivate var onClick: TouchUpInside?
    typealias TouchUpInside = () -> ()
    private var show = false
    
    convenience init() {
        self.init(frame: CGRect(x: screen_width - BoneRichConfig.closeWidth, y: 0, width: BoneRichConfig.closeWidth, height: BoneRichConfig.height))

        self.addTarget(self, action: #selector(BoneCloseBtn.switchAction), for: UIControlEvents.touchUpInside)
        
        self.setImage(self.keyBoardIcon, for: UIControlState.normal)
    }

    /// 隐藏键盘
    @objc private func switchAction() {
        switch type {
        case .close:
            self.onClick?()
        case .editing:
            UIApplication.shared.keyWindow?.endEditing(true)
        }
    }
}
