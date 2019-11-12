//
//  Observable+Chain.swift
//  UtilsKit
//
//  Created by 叶浩 on 2019/3/14.
//

import RxSwift
import RxCocoa

//MARK: - Thread
public extension ObservableType {
    func async() -> Observable<E> {
        return observeOn(ConcurrentDispatchQueueScheduler(qos: .background))
    }
    
    func sync() -> Observable<E> {
        return observeOn(MainScheduler.instance)
    }
}
