//
//  ImageCache.swift
//  iPlayer
//
//  Created by 叶浩 on 2019/11/7.
//  Copyright © 2019 叶浩. All rights reserved.
//

import UIKit

class ImageCache {
    static let `default` = ImageCache()
    
    let memoryStorage: MemoryStorage.Backend<UIImage>
    let diskStorage: DiskStorage.Backend<Data>
    let ioQueue: DispatchQueue
    
    init() {
        let config = DiskStorage.Config(directory: URL(fileURLWithPath: "/Cache/disk_cache"))
        self.diskStorage = try! DiskStorage.Backend<Data>(config: config)
        self.memoryStorage = MemoryStorage.Backend<UIImage>()
        self.ioQueue = DispatchQueue(label: "iPlayer")
    }
    
    func store(image: UIImage, forKey key: String, toDisk: Bool = true) {
        memoryStorage.store(value: image, forKey: key)
        
        guard toDisk else { return }
        ioQueue.async {
            try! self.diskStorage.store(value: image.jpegData(compressionQuality: 1), forKey: key)
        }
    }
}
