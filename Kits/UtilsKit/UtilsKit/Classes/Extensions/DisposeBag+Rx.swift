//
//  RxDisposeBagExtension.swift
//  YQJ
//
//  Created by jesse on 2017/8/25.
//  Copyright © 2017年 jesse. All rights reserved.
//

import RxSwift

private var kDisposeBagKey: Void?

public protocol RxDisposeBag: class {
    var disposeBag: DisposeBag { get }
    func dispose()
}

extension RxDisposeBag where Self: NSObject {
    private var _disposeBag: DisposeBag? {
        get {
            return associatedObject(for: &kDisposeBagKey) as? DisposeBag
        }
        set {
            setAssociatedObject(newValue, for: &kDisposeBagKey)
        }
    }
    
    public var disposeBag: DisposeBag {
        get {
            if let disposeBag = _disposeBag {
                return disposeBag
            }
            let disposeBag = DisposeBag()
            _disposeBag = disposeBag
            return disposeBag
        }
        set {
            _disposeBag = newValue
        }
    }
    
    public func dispose() {
        _disposeBag = nil
    }
}

extension NSObject: RxDisposeBag {}

