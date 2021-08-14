//
//  MyRidesHeaderView.swift
//  HopSkipDrive-Take-Home-Project
//
//  Created by Ryan Nguyen on 8/13/21.
//

import SnapKit
import UIKit

class MyRidesHeaderView: UITableViewHeaderFooterView {
    static let identifier = "MyRidesHeader"
    
    private let rideDate: UILabel = {
        let label = UILabel()
        label.text = "Thu 6/17"
        label.font = .systemFont(ofSize: 18, weight: .regular)
        return label
    }()
        
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        contentView.addSubview(rideDate)
        contentView.backgroundColor = .yellow
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        configureAutoLayout()
    }
    
    private func configureAutoLayout() {
        rideDate.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(25)
            make.centerY.equalToSuperview()
        }
    }
}
