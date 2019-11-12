//
//  DiskStorage.swift
//  iPlayer
//
//  Created by 叶浩 on 2019/11/11.
//  Copyright © 2019 叶浩. All rights reserved.
//

import UIKit

struct DiskStorage {
    class Backend<T: DataTransformable> {
        var config: Config
        
        init(config: Config) throws {
            self.config = config
            if !config.fileManager.fileExists(atPath: config.directory.path) {
                do {
                    try config.fileManager.createDirectory(at: config.directory, withIntermediateDirectories: true, attributes: nil)
                } catch {
                    throw FFmpegError.cacheError(.cannotCreateDirectory)
                }
            }
        }
        
        func store(value: T, forKey key: String) throws {
            let data: Data
            do {
                try data = value.toData()
            } catch {
                throw FFmpegError.cacheError(.cannotCreateDirectory)
            }
            
            let fileURL = cacheFileURL(forKey: key)
            config.fileManager.createFile(atPath: fileURL.path, contents: data, attributes: nil)
        }
        
        func cacheFileURL(forKey key: String) -> URL {
            return config.directory.appendingPathComponent(key.md5)
        }
        
        func removeFile(at url: URL) throws {
            try config.fileManager.removeItem(at: url)
        }
        
        func remove(forKey key: String) {
            try! removeFile(at: cacheFileURL(forKey: key))
        }
        
        func value(forKey key: String) throws -> T? {
            let fileManager = config.fileManager
            let fileURL = cacheFileURL(forKey: key)
            let filePath = fileURL.path
            guard fileManager.fileExists(atPath: filePath) else {
                return nil
            }
            
            do {
                return try Data(contentsOf: fileURL)
            } catch {
                throw FFmpegError.cacheError(reason: .cannotLoadDataFromDisk)
            }
        }
        
        func isCached(forKey key: String) -> Bool {
            do {
                guard let _ = try value(forKey: key) else {
                    return false
                }
                return true
            } catch {
                return false
            }
        }
    }
}

extension DiskStorage {
    struct Config {
        let directory: URL
        let fileManager: FileManager
        
        init(directory: URL, fileManager: FileManager = .default) {
            self.directory = directory
            self.fileManager = fileManager
        }
    }
}
