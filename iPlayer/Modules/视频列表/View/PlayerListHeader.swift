//
//  PlayerListHeader.swift
//  iPlayer
//
//  Created by 叶浩 on 2019/11/14.
//  Copyright © 2019 叶浩. All rights reserved.
//

import UIKit
import UtilsKit

class PlayerListHeader: UITableViewHeaderFooterView {
    fileprivate lazy var label: UILabel = {
        let label = UILabel()
        return label
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        ui()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension PlayerListHeader {
    fileprivate func ui() {
        backgroundView = UIView(frame: bounds)
        backgroundView!.backgroundColor = .white
        
        backgroundView!.addSubview(label)
        label.text = "文档"
        label.font = Font.medium(14)
        label.snp.makeConstraints {
            $0.left.equalToSuperview().offset(14)
            $0.right.equalToSuperview().offset(14)
            $0.top.bottom.equalToSuperview()
        }
    }
    
    func updateTitle(_ title: String) {
        label.text = title
    }
}
