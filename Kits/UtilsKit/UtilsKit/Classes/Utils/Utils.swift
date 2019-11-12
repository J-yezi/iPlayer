//
//  Utils.swift
//  BaseKit
//
//  Created by 叶浩 on 2019/10/30.
//

import UIKit

public struct Font {
    public static func medium(_ size: CGFloat) -> UIFont {
        return UIFont(name: "PingFangSC-Medium", size: size)!
    }
    
    public static func regular(_ size: CGFloat) -> UIFont {
        return UIFont(name: "PingFangSC-Regular", size: size)!
    }
}

public struct Color {
    public static let textGray = UIColor(red:0.518, green:0.514, blue:0.518, alpha: 1.000)
}
