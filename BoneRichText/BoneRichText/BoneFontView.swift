//
//  BoneFontView.swift
//  keyBoardPopUp
//
//  Created by 俞旭涛 on 2017/5/4.
//  Copyright © 2017年 Huangjunwei. All rights reserved.
//

import UIKit

class BoneFontView: BoneBasicView {
    
    
    public var getFontSize: CGFloat {
        get {
            return self.fontSize
        }
    }
    
    private var fontSize: CGFloat = 14
    private var show = false
    private var fontArray: [CGFloat] = [16, 18, 22, 26, 30, 36]

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.isHidden = true
        
        self.fontSize = fontArray[0]
        
        for i in 0..<self.fontArray.count {
            let button = UIButton(frame: CGRect(x: CGFloat(i) * BoneRichConfig.fontWidth, y: 0, width: BoneRichConfig.fontWidth, height: self.height))
            button.setTitle(String(format: "%.0f", self.fontArray[i]), for: UIControlState.normal)
            button.setTitleColor(UIColor.darkText, for: UIControlState.normal)
            button.setTitleColor(UIColor.orange, for: UIControlState.selected)
            button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
            button.tag = i + 300
            if self.fontSize == self.fontArray[i] {
                button.isSelected = true
                button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
            }
            button.addTarget(self, action: #selector(BoneFontView.action(button:)), for: UIControlEvents.touchUpInside)
            self.addSubview(button)
            if i == self.fontArray.count - 1 {
                self.width = button.right
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func action(button: UIButton) {
        button.isSelected = !button.isSelected
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        self.fontSize = self.fontArray[button.tag - 300]
        for i in 0..<self.fontArray.count {
            if (i + 300) != button.tag {
                let button = self.viewWithTag(i + 300) as? UIButton
                button?.isSelected = false
                button?.titleLabel?.font = UIFont.systemFont(ofSize: 15)
            }
        }
        self.isShow = false
    }
}
