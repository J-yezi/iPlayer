//
//  ImageDownloader.swift
//  iPlayer
//
//  Created by 叶浩 on 2019/11/12.
//  Copyright © 2019 叶浩. All rights reserved.
//

import UIKit

class ImageDownloader: NSObject {
    static let `default` = ImageDownloader()
    let queue = OperationQueue()
    private var tasks: [String: Operation] = [:]
    private let lock = NSLock()
    
    override init() {
        super.init()
        queue.maxConcurrentOperationCount = 3
    }
    
    func downloadImage(forKey key: String, completionHandler: ((Result<UIImage?, FFmpegError>) -> Void)? = nil) {
        lock.lock()
        defer { lock.unlock() }
        
        let operation: ImageTask
        if !tasks.keys.contains(path) {
            operation = ImageTask(path: path)
            tasks[path] = operation
            queue.addOperation(operation)
        } else {
            operation = tasks[path]
        }
        operation.addCallback(completionHandler)
    }
}
