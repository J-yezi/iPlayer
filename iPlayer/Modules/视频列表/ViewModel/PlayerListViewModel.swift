//
//  PlayerListViewModel.swift
//  iPlayer
//
//  Created by 叶浩 on 2019/10/28.
//  Copyright © 2019 叶浩. All rights reserved.
//

import RxSwift
import RxCocoa
import UtilsKit

class PlayerListViewModel: ViewModelData {
    struct Input {
        let load: Observable<Void>
    }

    struct Output {
        let data: Observable<[PlayerListSection]>
    }
    
    func transform(input: Input) -> Output {
        let data = input.load
            .flatMap { [weak self] _ -> Observable<[PlayerListSection]> in
                guard let `self` = self else { return Observable.empty() }
                return self.findDescribe()
            }
        return Output(data: data)
    }
}

extension PlayerListViewModel {
    fileprivate func findDescribe() -> Observable<[PlayerListSection]> {
        return Observable.create { [weak self] in
            let paths = self?.listPath()
            if let paths = paths {
                let items = paths.map{ path in PlayerListModel(title: path.0, path: path.1) }
                $0.onNext([PlayerListSection(model: 0, items: items)])
            }
            $0.onCompleted()
            return Disposables.create()
        }
    }
    
    fileprivate func listPath() -> [(String, String)]? {
        let manager = FileManager.default
        let urlForDocument = manager.urls(for: .documentDirectory, in:.userDomainMask)
        let url = urlForDocument[0] as URL
        
        var paths: [String]
        do {
            paths = try manager.contentsOfDirectory(atPath: url.path)
                .filter{ $0.hasSuffix("flv") || $0.hasSuffix("mp4") }
        } catch {
            paths = []
        }
        
        return paths.map{ ($0, url.path + "/" + $0) }
    }
}
