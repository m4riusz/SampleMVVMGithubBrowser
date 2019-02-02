//
//  Repository.swift
//  SampleGithubMVVMBrowser
//
//  Created by Mariusz Sut on 02/02/2019.
//  Copyright © 2019 Mariusz Sut. All rights reserved.
//

import Foundation

struct Repository: Codable {
    let name: String
    let owner: Owner
    let url: String
    let description: String?
    
    enum CodingKeys: String, CodingKey {
        case name = "full_name"
        case owner
        case url = "html_url"
        case description
    }
}
