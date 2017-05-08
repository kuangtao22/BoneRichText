#BoneRichText 富文本编辑器
## 简介

* BoneRichText是用纯 Swift 写成的富文本编辑器，供大家互相学习
* BoneRichText主要分为两个部分：BoneRichTools和BoneRichTextView

##环境要求
* iOS 7.0+
* Xcode 8 (Swift 3) 版

##BoneRichTextView
####textStyle: 字体样式

> textStyle.fontSize: 字号

> textStyle.isBold: 粗体

> textStyle.fontColor: 字体颜色

##BoneRichTools
获取字体样式
> textStyle

代理方法

* 操作richTools改变前
	
		func richText(richTools: BoneRichTools, type: BoneMainView.KeyItemType, beginDidChange textStyle: BoneRichTextStyle)

* 操作richTools改变后
		
		func richText(richTools: BoneRichTools, type: BoneMainView.KeyItemType, endDidChange textStyle: BoneRichTextStyle)
    
* 监控richTools位置变化    
    
		func richText(richTools: BoneRichTools, affineTransform form: CGAffineTransform)
   
   
   