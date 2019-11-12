//
//  PlayerListModel.swift
//  iPlayer
//
//  Created by 叶浩 on 2019/10/28.
//  Copyright © 2019 叶浩. All rights reserved.
//

import RxDataSources

typealias PlayerListSection = SectionModel<Int, PlayerListModel>

struct PlayerListModel {
    var title: String
    var path: String
    var image: UIImage?
    
    init(title: String, path: String, image: UIImage? = nil) {
        self.title = title
        self.image = image
        self.path = path
    }
}
