//
//  Owner.swift
//  SampleGithubMVVMBrowser
//
//  Created by Mariusz Sut on 02/02/2019.
//  Copyright © 2019 Mariusz Sut. All rights reserved.
//

import Foundation

struct Owner: Codable {
    let id: Int
    let login: String
    let avatarURL: String
    
    enum CodingKeys: String, CodingKey {
        case login, id
        case avatarURL = "avatar_url"
    }
}
