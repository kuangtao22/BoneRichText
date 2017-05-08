//
//  BoneMainView.swift
//  keyBoardPopUp
//
//  Created by 俞旭涛 on 2017/5/4.
//  Copyright © 2017年 Huangjunwei. All rights reserved.
//

import UIKit

extension BoneMainView {
    
    public func mainAction(cellback: mainTouchUpInside?) {
        self.onClick = cellback
    }
}

class BoneMainView: UIView {
    
    /// 是否是粗体
    public var isBold: Bool {
        get {
            if let boldBtn = self.viewWithTag(KeyItemType.bold.rawValue + 100) as? UIButton {
                return boldBtn.isSelected
            }
            return false
        }
    }
    
    public var btnColor: UIColor? {
        didSet {
            if let color = btnColor {
                let boldBtn = self.viewWithTag(KeyItemType.color.rawValue + 100) as? UIButton
                let image = boldBtn?.imageView?.image?.color(to: color)
                boldBtn?.setImage(image, for: UIControlState.normal)
            }
        }
    }

    private var imageArray = [UIImage(named: "BoneIcon.bundle/icon_image"),
                              UIImage(named: "BoneIcon.bundle/icon_font"),
                              UIImage(named: "BoneIcon.bundle/icon_bold"),
                              UIImage(named: "BoneIcon.bundle/icon_color")]
    
    /// 键盘功能类型
    ///
    /// - keyBoard: 切换键盘
    /// - font: 字体大小、粗细、斜体、下划线、中划线
    /// - color: 字体颜色
    /// - image: 照片、相册
    /// - hidden: 隐藏
    enum KeyItemType: Int {
        case font = 1
        case color = 3
        case image = 0
        case bold = 2
    }
    
    typealias mainTouchUpInside = (_ type: KeyItemType) -> ()
    fileprivate var onClick: mainTouchUpInside?
    
    convenience init() {
        self.init(frame: CGRect(x: 0, y: 0, width: screen_width, height: BoneRichConfig.height))
        
        for i in 0..<self.imageArray.count {
            let button = UIButton(frame: CGRect(x: CGFloat(i) * BoneRichConfig.mainItemWidth, y: 0, width: BoneRichConfig.mainItemWidth, height: self.height))
            button.setImage(self.imageArray[i], for: UIControlState.normal)
            button.tag = 100 + i
            if i == KeyItemType.bold.rawValue {
                button.setImage(self.imageArray[i]?.color(to: UIColor.orange), for: UIControlState.selected)
            }
            button.addTarget(self, action: #selector(BoneMainView.action(button:)), for: UIControlEvents.touchUpInside)
            self.addSubview(button)
            if i == self.imageArray.count - 1 {
                self.width = button.right
            }
        }
    }
    
    @objc private func action(button: UIButton) {
        if button.tag - 100 == KeyItemType.bold.rawValue {
            if let boldBtn = self.viewWithTag(KeyItemType.bold.rawValue + 100) as? UIButton {
                boldBtn.isSelected = !boldBtn.isSelected
            }
        }
        
        self.onClick?(KeyItemType.init(rawValue: button.tag - 100)!)
    }
}
