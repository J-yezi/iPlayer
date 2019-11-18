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
    
    var data: [PlayerListSection]!
}

extension PlayerListViewModel {
    fileprivate func findDescribe() -> Observable<[PlayerListSection]> {
        return Observable.create { [weak self] in
            let paths = self?.listPath()
            if let paths = paths {
                var result = [PlayerListSection]()
                paths.keys.forEach { key in
                    if key == "Documents" && result.count > 0 {
                        result.insert(PlayerListSection(model: "文档", items: paths[key]!.map { res in PlayerListModel(title: res.0, path: res.1) }), at: 0)
                    } else {
                        result.append(PlayerListSection(model: key == "Documents" ? "文档" : key, items: paths[key]!.map { res in PlayerListModel(title: res.0, path: res.1) }))
                    }
                }
                $0.onNext(result)
                self?.data = result
            }
            $0.onCompleted()
            return Disposables.create()
        }
    }
    
    fileprivate func listPath() -> [String: [(String, String)]]? {
        var paths = [String: [(String, String)]]()
        do {
            try findMovie(path: addPrefix(path: ""), items: &paths)
        } catch {}
        return paths
    }
    
    fileprivate func findMovie(path: String, items: inout [String: [(String, String)]]) throws {
        for item in try FileManager.default.contentsOfDirectory(atPath: path) {
            if isDirectory(path: path + "/" + item) {
                try findMovie(path: path + "/" + item, items: &items)
            } else if item.hasSuffix("flv") ||
                    item.hasSuffix("mp4") ||
                    item.hasSuffix("rmvb") {
                let key = path.components(separatedBy: "/").last!
                if !items.keys.contains(key) {
                    items[key] = [(String, String)]()
                }
                items[key]!.append((item, path + "/" + item))
            }
        }
    }
    
    fileprivate func isDirectory(path: String) -> Bool {
        var isDirectory = ObjCBool(false)
        FileManager.default.fileExists(atPath: path, isDirectory: &isDirectory)
        return isDirectory.boolValue
    }
    
    fileprivate func addPrefix(path: String) -> String {
        if path == "" {
            return "\(NSHomeDirectory())/Documents"
        }
        return "\(NSHomeDirectory())/Documents/\(path)"
    }
}
