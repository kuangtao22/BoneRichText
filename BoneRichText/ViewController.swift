//
//  ViewController.swift
//  BoneRichText
//
//  Created by 俞旭涛 on 2017/5/8.
//  Copyright © 2017年 俞旭涛. All rights reserved.
//

import UIKit

/*******
 - 尺寸规范:
 - 命名规范: 页面名称_viewName_sizeType
 */
let screen_width = UIScreen.main.bounds.size.width // 屏幕宽度
let screen_height = UIScreen.main.bounds.size.height // 屏幕高度
let screen_nav_height: CGFloat = 44 // 导航高度
let screen_statusBar_height = UIApplication.shared.statusBarFrame.size.height // 状态栏高度

class ViewController: UIViewController {

    var richText: BoneRichTextView!
    var richTools: BoneRichTools!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.richTools = BoneRichTools()
        self.richTools.delegate = self
        self.view.addSubview(self.richTools)
        
        self.richText = BoneRichTextView(frame: CGRect(x: 0, y: screen_nav_height, width: screen_width, height: screen_height - screen_nav_height - self.richTools.height), textContainer: nil)
        self.richText.textStyle = self.richTools.textStyle
        self.view.addSubview(self.richText)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    fileprivate func openPhoto(type: UIImagePickerControllerSourceType) {
        if UIImagePickerController.isSourceTypeAvailable(type) {
            let vc = UIImagePickerController()
            vc.sourceType = type
            vc.delegate = self
            self.present(vc, animated: true, completion: {
                
            })
        } else {
            
        }
        print(richText.htmlString)
    }
}

extension ViewController: UIAlertViewDelegate {
    func alertView(_ alertView: UIAlertView, clickedButtonAt buttonIndex: Int) {
        if buttonIndex == 0 {
            self.openPhoto(type: .photoLibrary)
        } else if buttonIndex == 1 {
            self.openPhoto(type: .camera)
        }
    }
}

extension ViewController: BoneRichToolsDelegate {
    
    func richText(richTools: BoneRichTools, affineTransform form: CGAffineTransform) {
        let height = screen_height - richTools.height - screen_nav_height
        if form.ty < 0 {
            self.richText.height = height + form.ty
        } else {
            self.richText.height = height
        }
    }
    
    func richText(richTools: BoneRichTools, type: BoneMainView.KeyItemType, beginDidChange textStyle: BoneRichTextStyle) {
        self.richText.textStyle = textStyle
        
        if type == .image {
            let alertView = UIAlertView()
            alertView.title = "插入图片"
            alertView.addButton(withTitle: "打开相册")
            alertView.addButton(withTitle: "打开相机")
            alertView.cancelButtonIndex = 0
            alertView.delegate = self
            alertView.show()
            
        } else if type == .bold {
            let range = NSRange(location: self.richText.lastSelectedRange.location, length: self.richText.lastSelectedRange.length)
            self.richText.setText(range: range, type: type)
            self.richText.selectedRange = range
        }
    }
    
    func richText(richTools: BoneRichTools, type: BoneMainView.KeyItemType, endDidChange textStyle: BoneRichTextStyle) {
        self.richText.textStyle = textStyle
        
        let range = NSRange(location: self.richText.lastSelectedRange.location, length: self.richText.lastSelectedRange.length)
        
        self.richText.setText(range: range, type: type)
        self.richText.selectedRange = range
    }
    
}

extension ViewController: UIImagePickerControllerDelegate {
    //选择图片成功后代理
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        self.dismiss(animated: true) {
            
        }
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            self.richText.setImage = image
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true) {
            
        }
    }
}

extension ViewController: UINavigationControllerDelegate {
    
}
