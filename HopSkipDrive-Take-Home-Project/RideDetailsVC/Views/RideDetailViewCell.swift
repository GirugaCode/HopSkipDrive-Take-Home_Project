//
//  RideDetailViewCell.swift
//  HopSkipDrive-Take-Home-Project
//
//  Created by Ryan Nguyen on 8/22/21.
//

import UIKit

class RideDetailViewCell: UITableViewCell {
    
    //MARK: UI COMPONENTS
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
    
    private lazy var addressStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [symbol, addressDetailStackView])
        stackView.distribution = .fillProportionally
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.spacing = 20
        return stackView
    }()
    
    let symbol: UIImageView = {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "circle")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private lazy var addressDetailStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [pickUpDropOffLabel, addressLabel])
        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        stackView.alignment = .fill
        return stackView
    }()
    
    let pickUpDropOffLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .semibold)
        label.text = "Pickup"
        return label
    }()
    
    let addressLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .regular)
        label.text = "12343 Los Angelas Way, CA"
        return label
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
    private func configureAutoLayout() {
        contentView.addSubview(backView)
        
        backView.snp.makeConstraints { (make) in
            make.height.equalToSuperview().multipliedBy(0.9)
            make.left.equalToSuperview().offset(25)
            make.right.equalToSuperview().offset(-25)
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        
        backView.addSubview(addressStackView)
        
        symbol.snp.makeConstraints { make in
            make.width.equalTo(15)
            make.height.equalTo(15)
        }
        
        addressStackView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview()
            make.height.equalTo(40)
            make.width.equalTo(40)
        }
    }
    
    //MARK: - PUBLIC FUNCTION
    func configureCell(ride: Ride) {
        
    }
}
