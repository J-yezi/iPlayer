//
//  PlayerListController.swift
//  iPlayer
//
//  Created by 叶浩 on 2019/10/28.
//  Copyright © 2019 叶浩. All rights reserved.
//

import UIKit
import BaseKit
import RxSwift
import RxCocoa
import UtilsKit
import RxDataSources
import Lottie

class PlayerListController: BaseController {
    fileprivate let viewModel = PlayerListViewModel()
    fileprivate lazy var upBtn: LOTAnimationView = {
        let upBtn = LOTAnimationView()
        upBtn.loopAnimation = true
        return upBtn
    }()
    
    fileprivate lazy var tableView: UITableView = {
        let tableView = UITableView(frame: view.bounds, style: UITableView.Style.plain)
        tableView.register(cell: PlayerListCell.self)
        tableView.rowHeight = 94
        tableView.tableFooterView = UIView()
        return tableView
    }()
    
    fileprivate lazy var dataSource = {
        return RxTableViewSectionedReloadDataSource<PlayerListSection>(configureCell: { (dataSource, tableView, indexPath, model) -> UITableViewCell in
            let cell: PlayerListCell = tableView.dequeueCell(at: indexPath)
            cell.updateModel(model)
            return cell
        })
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        rx()
    }
}

extension PlayerListController {
    fileprivate func rx() {
        let input = PlayerListViewModel.Input(load: Observable.just(()))
        let output = viewModel.transform(input: input)
        
        output.data
        .bind(to: tableView.rx.items(dataSource: dataSource))
        .disposed(by: disposeBag)

//        tableView.rx.modelSelected(PlayerListModel.self)
//        .subscribe(onNext: { [weak self] in
////            self?.navigationController?.pushViewController(PlayerController(url: $0.path), animated: true)
//        }).disposed(by: disposeBag)
    }
}
