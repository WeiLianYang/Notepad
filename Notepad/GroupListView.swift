//
//  GroupListView.swift
//  Notepad
//
//  Created by WilliamYang on 2022/2/12.
//

import UIKit

class GroupListView: UIScrollView {

    // 列间距
    let interitemSpacing = 15
    
    // 行间距
    let lineSpacing = 20
    
    // 分组标题数组
    var dataArray: Array<String>?
    
    // 分组按钮数组
    var buttonArray: Array<UIButton> = Array<UIButton>()
    
    func updateLayout() {
        // 计算每个按钮的宽高
        let itemWidth = (self.frame.size.width - CGFloat(4 * interitemSpacing)) / 3
        let itemHeight = itemWidth
        
        // 移除已有的按钮
        buttonArray.forEach({ element in
            element.removeFromSuperview()
        })
        // 清空所有按钮
        buttonArray.removeAll()
        
        // 开始布局
        if dataArray != nil && dataArray!.count > 0 {
            // 遍历
            for index in 0 ..< dataArray!.count {
                let btn = UIButton(type: .system)
                btn.setTitle(dataArray![index], for: .normal)
                // 计算按钮位置
                btn.frame = CGRect(x: CGFloat(interitemSpacing) + CGFloat(index % 3) * (itemWidth + CGFloat(interitemSpacing)), y: CGFloat(lineSpacing) + CGFloat(index / 3) * (itemHeight + CGFloat(lineSpacing)), width: itemWidth, height: itemHeight)
                
                btn.backgroundColor = UIColor.colorWithHexString(hex: "#FDEDEC")
                
                // 设置圆角
                btn.layer.masksToBounds = true
                btn.layer.cornerRadius = 16
                btn.setTitleColor(UIColor.darkGray, for: .normal)
                btn.tag = index
                btn.addTarget(self, action: #selector(onBtnClick), for: .touchUpInside)
                self.addSubview(btn)
                buttonArray.append(btn)
            }
            // 设置滚动视图内容尺寸
            self.contentSize = CGSize(width: 0, height: buttonArray.last!.frame.origin.y + buttonArray.last!.frame.size.height + CGFloat(lineSpacing))
        }
    }
    
    var groupClickDelegate: GroupClickDelegate?
    
    @objc func onBtnClick(btn: UIButton) {
        print(dataArray![btn.tag])
        groupClickDelegate?.onGroupClick(title: dataArray![btn.tag])
    }
    
}

protocol GroupClickDelegate {
    func onGroupClick(title: String)
}
