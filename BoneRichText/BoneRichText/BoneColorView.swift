//
//  BoneColorView.swift
//  keyBoardPopUp
//
//  Created by 俞旭涛 on 2017/5/4.
//  Copyright © 2017年 Huangjunwei. All rights reserved.
//

import UIKit


class BoneColorView: BoneBasicView {

    /// 获取当前颜色
    public var getColor: UIColor {
        get {
            return self.color
        }
    }
    
    private var show = false
    private var color: UIColor! // 当前选中颜色
    private var colorArray = [BoneTools.shared.checkColor(code: "#000000"),
                              BoneTools.shared.checkColor(code: "#666666"),
                              BoneTools.shared.checkColor(code: "#999999"),
                              BoneTools.shared.checkColor(code: "#ff4d3b"),
                              BoneTools.shared.checkColor(code: "#973bff"),
                              BoneTools.shared.checkColor(code: "#3b7cff"),
                              BoneTools.shared.checkColor(code: "#00b2ec"),
                              BoneTools.shared.checkColor(code: "#2fc95a"),
                              BoneTools.shared.checkColor(code: "#ff9000"),
                              BoneTools.shared.checkColor(code: "#ff4200"),
                              BoneTools.shared.checkColor(code: "#661a00")]


    override init(frame: CGRect) {
        super.init(frame: frame)
        self.isHidden = true
        
        self.color = self.colorArray[0]
        
        let size: CGFloat = self.height - 10
        for color in self.colorArray {
            let i = self.colorArray.index(of: color)!
            let left = 10 + (size + 10) * CGFloat(i)
            let button = UIButton(frame: CGRect(x: left, y: 5, width: size, height: size))
            button.backgroundColor = color
            if self.getColor == color {
                button.isSelected = true
            }
            button.layer.cornerRadius = button.height / 2
            button.setImage(UIImage(named: "BoneIcon.bundle/icon_seleColor"), for: UIControlState.selected)
            button.setImage(nil, for: UIControlState.normal)
            button.tag = i + 200
            button.imageView?.contentMode = .scaleAspectFill
            button.addTarget(self, action: #selector(BoneColorView.selectAction(button:)), for: UIControlEvents.touchUpInside)
            self.addSubview(button)
            if i == self.colorArray.count - 1 {
                self.width = button.right + 10
            }
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    /// 颜色选择
    ///
    /// - Parameter button: 颜色按钮
    @objc private func selectAction(button: UIButton) {
        button.isSelected = !button.isSelected
        for i in 0..<self.colorArray.count {
            let view = self.viewWithTag(i + 200) as? UIButton
            if (i + 200) != button.tag {
                view?.isSelected = false
            }
        }
        self.color = self.colorArray[button.tag - 200]
        self.isShow = false
    }

    
}
