//
//  GithubBrowserController.swift
//  SampleGithubMVVMBrowser
//
//  Created by Mariusz Sut on 02/02/2019.
//  Copyright © 2019 Mariusz Sut. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import MBProgressHUD
import SDWebImage

class GithubBrowserController: UITableViewController {
    
    fileprivate let viewModel: GithubBrowserViewModelProtocol = GithubBrowserViewModel(repository: GithubBrowserRepository())
    fileprivate var searchController: UISearchController?
    fileprivate var customView: CustomView?
    fileprivate let bag = DisposeBag()
    
    override func viewDidLoad() {
        self.initTableView()
        self.initSearchController()
        self.initCustomView()
        self.initBindings()
    }
    
    fileprivate func initTableView() {
        self.tableView.dataSource = nil
        self.tableView.delegate = nil
        self.tableView.tableFooterView = UIView()
        self.tableView.register(RepositoryCell.self, forCellReuseIdentifier: "Cell")
    }
    
    fileprivate func initSearchController() {
        self.searchController = UISearchController(searchResultsController: nil)
        self.tableView.tableHeaderView = self.searchController!.searchBar
    }
    
    fileprivate func initCustomView() {
        self.customView = CustomView()
        self.customView!.state = .empty
        self.tableView.backgroundView = self.customView
    }
    
    fileprivate func initBindings() {
        self.searchController?.searchBar.rx.text.orEmpty
            .bind(to: self.viewModel.query)
            .disposed(by: self.bag)
        
        self.viewModel.isEmptyDriver()
            .do(onNext: { (isEmpty) in
                guard isEmpty else {
                    return
                }
                self.customView?.state = .empty
            })
            .drive()
            .disposed(by: self.bag)
        
        self.viewModel.errorDriver()
            .do(onNext: { (error) in
                guard error.count > 0 else {
                    return
                }
                self.customView?.state = .error(error: error)
            })
            .drive()
            .disposed(by: self.bag)
        
        self.viewModel
            .isLoadingDriver()
            .do(onNext: { (isLoading) in
                guard isLoading else {
                    MBProgressHUD.hide(for: self.view, animated: true)
                    return
                }
                MBProgressHUD.showAdded(to: self.view, animated: true)
            })
            .drive()
            .disposed(by: self.bag)
        
        self.viewModel.repositoriesDriver()
            .drive(self.tableView.rx.items(cellIdentifier: "Cell", cellType: RepositoryCell.self)) { _, item, cell in
                cell.avatarImage?.sd_setImage(with: URL(string: item.owner.avatarURL)!)
                cell.repositoryNameLabel?.text = item.name
                cell.repositoryDescriptionLabel?.text = item.description
            }
            .disposed(by: self.bag)
    }
}
