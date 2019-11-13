//
//  PlayerListCell.swift
//  iPlayer
//
//  Created by 叶浩 on 2019/10/28.
//  Copyright © 2019 叶浩. All rights reserved.
//

import UIKit
import UtilsKit

class PlayerListCell: UITableViewCell {
    fileprivate lazy var coverView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.backgroundColor = .gray
        return imageView
    }()
    fileprivate lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.font = Font.medium(15)
        label.lineBreakMode = NSLineBreakMode.byTruncatingMiddle
        return label
    }()
    fileprivate lazy var containsView: UIView = {
        let view = UIView()
        return view
    }()
    fileprivate lazy var timeLabel: UILabel = {
        let label = UILabel()
        label.font = Font.medium(12)
        label.textColor = Color.textGray
        return label
    }()
    fileprivate lazy var cacheLabel: UILabel = {
        let label = UILabel()
        label.font = Font.medium(12)
        label.textColor = Color.textGray
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        ui()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension PlayerListCell {
    fileprivate func ui() {
        addSubview(coverView)
        coverView.snp.makeConstraints {
            $0.left.top.equalToSuperview().offset(14)
            $0.bottom.equalToSuperview().offset(-14)
            $0.width.equalTo(104)
        }
        
        addSubview(containsView)
        containsView.addSubview(titleLabel)
        containsView.addSubview(timeLabel)
        containsView.addSubview(cacheLabel)
        containsView.snp.makeConstraints {
            $0.left.equalTo(coverView.snp.right).offset(14)
            $0.right.equalToSuperview().offset(-44)
            $0.centerY.equalToSuperview()
        }
        titleLabel.snp.makeConstraints {
            $0.left.top.right.equalToSuperview()
        }
        timeLabel.snp.makeConstraints {
            $0.left.bottom.equalToSuperview()
            $0.top.equalTo(titleLabel.snp.bottom).offset(5)
        }
        cacheLabel.snp.makeConstraints {
            $0.left.equalTo(timeLabel.snp.right).offset(7)
            $0.top.bottom.equalTo(timeLabel)
        }
    }
    
    func updateModel(_ model: PlayerListModel) {
        titleLabel.text = model.title
        timeLabel.text = "23:40"
        cacheLabel.text = "610.23M"
        print("----", model.path)
        coverView.setImage(forKey: model.path)
    }
}
