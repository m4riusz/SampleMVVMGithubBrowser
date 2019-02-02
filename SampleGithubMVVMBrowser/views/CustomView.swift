//
//  EmptyView.swift
//  SampleGithubMVVMBrowser
//
//  Created by Mariusz Sut on 02/02/2019.
//  Copyright © 2019 Mariusz Sut. All rights reserved.
//

import UIKit

class CustomView: UIView {
    
    fileprivate var titleLabel: UILabel?
    fileprivate var descriptionLabel: UILabel?
    
    var state: State = .empty {
        didSet {
            self.updateViewForState()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initialize()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.initialize()
    }
    
    fileprivate func initialize() {
        self.initTitleLabel()
        self.initDescriptionLabel()
    }
    
    fileprivate func updateViewForState() {
        switch state {
        case .empty:
            self.titleLabel?.text = "Empty"
            self.descriptionLabel?.text = "No repositories found!"
        case .error(let error):
            self.titleLabel?.text = "Error"
            self.descriptionLabel?.text = error
        }
    }
    
    fileprivate func initTitleLabel() {
        self.titleLabel = UILabel()
        self.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        self.addSubview(self.titleLabel!)
        
        self.titleLabel?.snp.makeConstraints({ (make) in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(-10)
        })
    }
    
    
    fileprivate func initDescriptionLabel() {
        self.descriptionLabel = UILabel()
        self.descriptionLabel?.font = UIFont.systemFont(ofSize: 14)
        self.descriptionLabel?.textColor = .gray
        self.addSubview(self.descriptionLabel!)
        
        self.descriptionLabel?.snp.makeConstraints({ (make) in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(10)
        })
    }
    
    enum State {
        case empty
        case error(error: String)
    }
}
