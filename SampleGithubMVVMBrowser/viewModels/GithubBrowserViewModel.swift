//
//  GithubBrowserViewModel.swift
//  SampleGithubMVVMBrowser
//
//  Created by Mariusz Sut on 02/02/2019.
//  Copyright © 2019 Mariusz Sut. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

protocol GithubBrowserViewModelProtocol {
    
    var query: BehaviorSubject<String> { get }
    
    func repositoriesDriver()-> Driver<[Repository]>
    func errorDriver()-> Driver<String>
    func isEmptyDriver()-> Driver<Bool>
    func isLoadingDriver()-> Driver<Bool>
}

struct GithubBrowserViewModel: GithubBrowserViewModelProtocol {
    
    fileprivate let repository: GithubBrowserRepositoryProtocol
    fileprivate let items: BehaviorRelay<[Repository]> = BehaviorRelay(value: [])
    fileprivate let isEmpty: BehaviorRelay<Bool> = BehaviorRelay(value: false)
    fileprivate let error: BehaviorRelay<String> = BehaviorRelay(value: "")
    fileprivate let isLoading: BehaviorRelay<Bool> = BehaviorRelay(value: false)
    fileprivate let bag = DisposeBag()
    
    let query: BehaviorSubject<String> = BehaviorSubject(value: "")

    init(repository: GithubBrowserRepositoryProtocol) {
        self.repository = repository
        self.config()
    }
    
    fileprivate func config() {
        self.query.asObserver()
            .throttle(0.3, scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .do(onNext: { (_) in
                self.items.accept([])
                self.error.accept("")
                self.isEmpty.accept(true)
                self.isLoading.accept(true)
            })
            .flatMapLatest(self.repository.findForRepository)
            .subscribe(onNext: { (items) in
                self.items.accept(items)
                self.error.accept("")
                self.isEmpty.accept(items.count == 0)
                self.isLoading.accept(false)
            }, onError: { (error) in
                self.items.accept([])
                self.error.accept(error.localizedDescription)
                self.isEmpty.accept(true)
                self.isLoading.accept(false)
            })
            .disposed(by: self.bag)
    }
    
    func repositoriesDriver() -> Driver<[Repository]> {
        return self.items.asDriver()
    }
    
    func errorDriver()-> Driver<String> {
        return self.error.asDriver().distinctUntilChanged()
    }
    
    func isEmptyDriver() -> Driver<Bool> {
        return self.isEmpty.asDriver().distinctUntilChanged()
    }
    
    func isLoadingDriver() -> Driver<Bool> {
        return self.isLoading.asDriver().distinctUntilChanged()
    }
}
