//
//  Base.swift
//  SampleGithubMVVMBrowser
//
//  Created by Mariusz Sut on 02/02/2019.
//  Copyright © 2019 Mariusz Sut. All rights reserved.
//

import Foundation

struct List<T: Codable>: Codable {
    let totalCount: Int
    let finished: Bool
    let items: [T]
    
    enum CodingKeys: String, CodingKey {
        case totalCount = "total_count"
        case finished = "incomplete_results"
        case items
    }
}
