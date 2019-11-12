//
//  FFmpegManager.swift
//  iPlayer
//
//  Created by 叶浩 on 2019/11/7.
//  Copyright © 2019 叶浩. All rights reserved.
//

import UIKit

class FFmpegManager {
    static let share = FFmpegManager()
    var cache: ImageCache
    var downloader: ImageDownloader
    
    init() {
        cache = .default
        downloader = .default
    }
    
    func retrieveImage(forKey key: String, completionHandler: ((Result<UIImage?, FFmpegError>) -> Void)?) {
        if cache.imageCachedType(forKey: key) != .none {
            cache.retrieveImage(forKey: key, completionHandler: completionHandler)
        } else {
            downloader.downloadImage(forKey: key, completionHandler: completionHandler)
        }
    }
}
