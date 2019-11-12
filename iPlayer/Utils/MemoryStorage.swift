//
//  MemoryStorage.swift
//  iPlayer
//
//  Created by 叶浩 on 2019/11/11.
//  Copyright © 2019 叶浩. All rights reserved.
//

import UIKit

struct MemoryStorage {
    class Backend<T> {
        let storage = NSCache<NSString, StorageObject<T>>()
        private let lock = NSLock()
        
        func store(value: T, forKey key: String) {
            lock.lock()
            defer { lock.unlock() }
            
            let object = StorageObject(value)
            storage.setObject(object, forKey: key as NSString)
        }
        
        func remove(forKey key: String) {
            lock.lock()
            defer { lock.unlock() }
            
            storage.removeObject(forKey: key as NSString)
        }
        
        func removeAll() {
            lock.lock()
            defer { lock.unlock() }
            
            storage.removeAllObjects()
        }
        
        func value(forKey key: String) -> T? {
            guard let object = storage.object(forKey: key as NSString) else {
                return nil
            }
            return object.value
        }
        
        func isCached(forKey key: String) -> Bool {
            guard let _ = value(forKey: key) else {
                return false
            }
            return true
        }
    }
}


extension MemoryStorage {
    class StorageObject<T> {
        let value: T
        
        init(_ value: T) {
            self.value = value
        }
    }
}
