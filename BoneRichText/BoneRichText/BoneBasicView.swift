//
//  BoneBasicView.swift
//  keyBoardPopUp
//
//  Created by 俞旭涛 on 2017/5/6.
//  Copyright © 2017年 Huangjunwei. All rights reserved.
//

import UIKit

extension BoneBasicView {
    /// 显示事件
    ///
    /// - Parameter cellback: <#cellback description#>
    public func showAction(cellback: @escaping TouchUpInside) {
        self.onClick = cellback
    }
}


class BoneBasicView: UIView {

    /// 显示状态
    public var isShow: Bool {
        get {
            return self.show
        }
        set {
            self.show = newValue
            self.animate()
        }
    }
    
    private var show = false
    typealias TouchUpInside = (_ isShow: Bool) -> ()
    fileprivate var onClick: TouchUpInside?
    
    convenience init() {
        self.init(frame: CGRect(x: screen_width, y: 0, width: screen_width, height: BoneRichConfig.height))
        self.isHidden = true
    }

    /// 动画（显示/隐藏）
    ///
    /// - Parameter isShow: 是否显示
    private func animate() {
        if self.isShow {
            UIView.animate(withDuration: 0.3, animations: {
                self.isHidden = false
                self.transform = CGAffineTransform(translationX: -screen_width, y: 0)
            }) { (finished) in
                self.onClick?(self.show)
            }
        } else {
            UIView.animate(withDuration: 0.3, animations: {
                self.transform = CGAffineTransform.identity
                
            }) { (finished) in
                self.isHidden = true
                self.onClick?(self.show)
            }
        }
    }
}
