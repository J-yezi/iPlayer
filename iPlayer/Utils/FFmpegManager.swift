//
//  FFmpegManager.swift
//  iPlayer
//
//  Created by 叶浩 on 2019/11/7.
//  Copyright © 2019 叶浩. All rights reserved.
//

import UIKit

class FFmpegManager {
    static let `default` = FFmpegManager()
    var cache: ImageCache
    var downloader: ImageDownloader
    
    init() {
        cache = .default
        downloader = .default
    }
    
    func retrieveImage(forKey key: String, completionHandler: ((Result<UIImage, FFmpegError>) -> Void)?) {
        print("----", cache.imageCachedType(forKey: key))
        if cache.imageCachedType(forKey: key) != .none {
            cache.retrieveImage(forKey: key, completionHandler: completionHandler)
        } else {
            func cacheImage(_ result: Result<UIImage, FFmpegError>) {
                switch result {
                case .success(let image):
                    cache.store(image: image, forKey: key, toDisk: true) {
                        completionHandler?(.success(image))
                    }
                default:
                     break
                }
            }
            downloader.downloadImage(forKey: key, completionHandler: cacheImage)
        }
    }
}
