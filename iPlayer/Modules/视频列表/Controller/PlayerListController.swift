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

class PlayerListController: BaseController {
    fileprivate let viewModel = PlayerListViewModel()
    
    fileprivate lazy var tableView: UITableView = {
        let tableView = UITableView(frame: view.bounds, style: UITableView.Style.plain)
        tableView.register(cell: PlayerListCell.self)
        tableView.register(header: PlayerListHeader.self)
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
        tableView.rx.setDelegate(self)
            .disposed(by: disposeBag)
        
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

extension PlayerListController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header: PlayerListHeader = tableView.dequeueHeaderFooter()
        header.updateTitle(viewModel.data[section].model)
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
}
