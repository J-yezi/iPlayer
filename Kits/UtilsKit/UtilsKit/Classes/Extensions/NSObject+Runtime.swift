//
//  NSObjectExtension.swift
//  YQJ
//
//  Created by jesse on 2017/8/25.
//  Copyright © 2017年 jesse. All rights reserved.
//

import Foundation

extension NSObject {
    func associatedObject(for key: UnsafeRawPointer) -> Any? {
        return objc_getAssociatedObject(self, key)
    }
    
    func setAssociatedObject(_ object: Any?, for key: UnsafeRawPointer) {
        objc_setAssociatedObject(self, key, object, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }
}
