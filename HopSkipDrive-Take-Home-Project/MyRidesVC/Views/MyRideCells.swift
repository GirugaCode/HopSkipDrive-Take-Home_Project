//
//  MyRideCells.swift
//  HopSkipDrive-Take-Home-Project
//
//  Created by Ryan Nguyen on 8/13/21.
//

import UIKit
import SnapKit

class MyRidesCell: UITableViewCell {
    
    //MARK: - UI COMPONENTS
    private lazy var backView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.shadowColor = UIColor.gray.cgColor
        view.layer.shadowOpacity = 0.3
        view.layer.shadowOffset = .init(width: 0, height: 0)
        view.layer.shadowRadius = 8
        view.layer.cornerRadius = 10
        return view
    }()
    
    //MARK: - INIT
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        contentView.backgroundColor = .white
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - OVERRIDE FUNCTIONS
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layoutIfNeeded()
        
        configureAutoLayout()

    }
    
    //MARK: - PRIVATE FUNCTION
    /// Configures layout of the Playback Cell
    private func configureAutoLayout() {
        contentView.addSubview(backView)
        
        backView.snp.makeConstraints { (make) in
            make.height.equalToSuperview().multipliedBy(0.9)
            make.left.equalToSuperview().offset(25)
            make.right.equalToSuperview().offset(-25)
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        
    }

}
