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
            do { lock.unlock() }
            
            let object = StorageObject(value)
            storage.setObject(object, forKey: key as NSString)
        }
        
        func remove(forKey key: String) {
            lock.lock()
            do { lock.unlock() }
            
            storage.removeObject(forKey: key as NSString)
        }
        
        func removeAll() {
            lock.lock()
            do { lock.unlock() }
            
            storage.removeAllObjects()
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
