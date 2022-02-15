//
//  ext.swift
//  Notepad
//
//  Created by WilliamYang on 2022/2/15.
//

import UIKit

extension UIColor {
    
    class var cFFFFFF: UIColor {
        return UIColor.colorWithHexString(hex: "#FFFFFF")
    }
    
    class var c232323: UIColor {
        return UIColor.colorWithHexString(hex: "#232323")
    }
    
    // MARK颜色转图片
    var image: UIImage {
        let rect: CGRect = CGRect(x: 0, y: 0, width: 1, height: 1)
        
        UIGraphicsBeginImageContext(rect.size)
        
        let context: CGContext = UIGraphicsGetCurrentContext()!
        
        context.setFillColor(self.cgColor)
        
        context.fill(rect)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsGetCurrentContext()
        
        return image!
    }
    
    class func colorWithHexString (hex: String) -> UIColor {
        var cString: String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

           if (cString.hasPrefix("#")) {
               cString.remove(at: cString.startIndex)
           }

           if ((cString.count) != 6) {
               return UIColor.gray
           }

           var rgbValue: UInt64 = 0
           Scanner(string: cString).scanHexInt64(&rgbValue)

           return UIColor(
               red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
               green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
               blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
               alpha: CGFloat(1.0)
           )
    }

}
