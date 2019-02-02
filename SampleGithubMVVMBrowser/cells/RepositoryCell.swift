//
//  RepositoryCell.swift
//  SampleGithubMVVMBrowser
//
//  Created by Mariusz Sut on 02/02/2019.
//  Copyright © 2019 Mariusz Sut. All rights reserved.
//

import CoreGraphics
import UIKit
import SnapKit

class RepositoryCell: UITableViewCell {
    
    var avatarImage: UIImageView?
    var repositoryNameLabel: UILabel?
    var repositoryDescriptionLabel: UILabel?
    
    fileprivate struct Sizes {
        static let AvatarWidth: CGFloat = 100
        static let AvatarHeight: CGFloat = 100
    }
    
    fileprivate struct Spacings {
        static let AvatarTop: CGFloat = 8
        static let AvatarLeft: CGFloat = 8
        static let AvatarBottom: CGFloat = -8
        static let RepositoryNameTop: CGFloat = 8
        static let RepositoryNameLeft: CGFloat = 8
        static let RepositoryNameRight: CGFloat = -8
        static let RepositoryDescriptionTop: CGFloat = 8
        static let RepositoryDescriptionLeft: CGFloat = 8
        static let RepositoryDescriptionRight: CGFloat = -8
        static let RepositoryDescriptionBottom: CGFloat = -8
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.initialize()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.initialize()
    }
    
    fileprivate func initialize() {
        self.initAvatarImage()
        self.initRepositoryNameLabel()
        self.initRepositoryDescriptionLabel()
    }
    
    fileprivate func initAvatarImage() {
        self.avatarImage = UIImageView()
        self.addSubview(self.avatarImage!)
        
        self.avatarImage?.snp.makeConstraints({ (make) in
            make.width.equalTo(Sizes.AvatarWidth)
            make.height.equalTo(Sizes.AvatarHeight)
            make.top.equalToSuperview().offset(Spacings.AvatarTop)
            make.left.equalToSuperview().offset(Spacings.AvatarLeft)
            make.bottom.equalToSuperview().offset(Spacings.AvatarBottom)
        })
    }
    
    fileprivate func initRepositoryNameLabel() {
        self.repositoryNameLabel = UILabel()
        self.repositoryNameLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        self.repositoryNameLabel?.numberOfLines = 1
        self.addSubview(self.repositoryNameLabel!)
        
        self.repositoryNameLabel?.snp.makeConstraints({ (make) in
            make.top.equalToSuperview().offset(Spacings.RepositoryNameTop)
            make.left.equalTo(self.avatarImage!.snp.right).offset(Spacings.RepositoryNameLeft)
            make.right.equalToSuperview().offset(Spacings.RepositoryNameRight)
        })
    }
    
    fileprivate func initRepositoryDescriptionLabel() {
        self.repositoryDescriptionLabel = UILabel()
        self.repositoryDescriptionLabel?.font = UIFont.systemFont(ofSize: 14)
        self.repositoryDescriptionLabel?.numberOfLines = 0
        self.repositoryDescriptionLabel?.textColor = .gray
        self.addSubview(self.repositoryDescriptionLabel!)
        
        self.repositoryDescriptionLabel?.snp.makeConstraints({ (make) in
            make.top.equalTo(self.repositoryNameLabel!.snp.bottom).offset(Spacings.RepositoryDescriptionTop)
            make.left.equalTo(self.avatarImage!.snp.right).offset(Spacings.RepositoryDescriptionLeft)
            make.right.equalToSuperview().offset(Spacings.RepositoryDescriptionRight)
            make.bottom.greaterThanOrEqualToSuperview().offset(Spacings.RepositoryDescriptionBottom)
        })
    }
}

