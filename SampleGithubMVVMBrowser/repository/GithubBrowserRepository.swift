//
//  GithubBrowserRepository.swift
//  SampleGithubMVVMBrowser
//
//  Created by Mariusz Sut on 02/02/2019.
//  Copyright © 2019 Mariusz Sut. All rights reserved.
//

import RxCocoa
import RxSwift
import Foundation
import Alamofire

protocol GithubBrowserRepositoryProtocol {
    func findForRepository(query: String)-> Single<[Repository]>
}

struct GithubBrowserRepository: GithubBrowserRepositoryProtocol {
    
    func findForRepository(query: String) -> Single<[Repository]> {
        return Single.create { single in
            let disposable = Disposables.create()
            
            AF.request("https://api.github.com/search/repositories?q=\(query)&sort=stars&order=desc")
                .responseDecodable(completionHandler: { (response: DataResponse<List<Repository>>) in
                    switch response.result {
                    case .success(let value):
                        single(.success(value.items))
                    case .failure(let error):
                        single(.error(error))
                    }
            })
            return disposable
        }
    }
}
