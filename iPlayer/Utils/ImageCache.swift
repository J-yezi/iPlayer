//
//  ImageCache.swift
//  iPlayer
//
//  Created by 叶浩 on 2019/11/7.
//  Copyright © 2019 叶浩. All rights reserved.
//

import UIKit

enum CacheType {
    case none
    case memory
    case disk
}

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
    
    func storeToDisk(image: UIImage, forKey key: String) {
        ioQueue.async {
            try! self.diskStorage.store(value: image.jpegData(compressionQuality: 1), forKey: key)
        }
    }
    
    func removeImage(forKey key: String, fromMemory: Bool = true, fromDisk: Bool = true) {
        if fromMemory {
            memoryStorage.remove(forKey: key)
        }
        if fromDisk {
            ioQueue.async {
                diskStorage.remove(forKey: key)
            }
        }
    }
    
    func retrieveImage(forKey key: String, completionHandler: ((Result<UIImage?, FFmpegError>) -> Void)?) {
        if let image = retrieveImageInMemoryCache(forKey: key) {
            DispatchQueue.main.async {
                completionHandler(.success(image))
            }
        } else {
            retrieveImage(forKey: key, completionHandler: completionHandler)
        }
    }
    
    func retrieveImageInMemoryCache(forKey key: String) -> UIImage? {
        return memoryStorage.value(forKey: key)
    }
    
    func retrieveImageInDiskCache(forKey key: String, completionHandler: @escaping (Result<UIImage?, FFmpegError>) -> Void) {
        ioQueue.async {
            do {
                let data = try self.diskStorage.value(forKey: key)
                let image = UIImage(data: data)
                completionHandler(.success(image))
            } catch {
                completionHandler(.failure($0))
            }
        }
    }
    
    func imageCachedType(forKey key: String) -> CacheType {
        if memoryStorage.isCached(forKey: key) { return .memory }
        if diskStorage.isCached(forKey: key) { return .disk }
        return .none
    }
}
