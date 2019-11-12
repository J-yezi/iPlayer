//
//  ImageTask.swift
//  iPlayer
//
//  Created by 叶浩 on 2019/11/12.
//  Copyright © 2019 叶浩. All rights reserved.
//

import UIKit

class ImageTask: Operation {
    var path: String!
    let callbacks = [((Result<UIImage?, FFmpegError>) -> Void)]()
    let lock = NSLock()
    
    init(path: String) {
        super.init()
        self.path = path
    }
    
    func addCallback(_ callback: ((Result<UIImage?, FFmpegError>) -> Void)?) {
        if callback != nil {
            lock.lock()
            defer { lock.unlock() }
            callbacks.append(callback!)
        }
    }
    
    override func main() {
        let model = FFmpegModel(path)
        let iamge = model.cover()
        for callback in callbacks {
            callback()
        }
    }
}
