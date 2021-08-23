//
//  MyRidesHeaderView.swift
//  HopSkipDrive-Take-Home-Project
//
//  Created by Ryan Nguyen on 8/13/21.
//

import SnapKit
import UIKit

class MyRidesHeaderView: UITableViewHeaderFooterView {
    
    //MARK: - PROPERTIES
    static let identifier = "MyRidesHeader"
    
    //MARK: - UI COMPONENTS
    let rideDate: UILabel = {
        let label = UILabel()
        label.text = "Thu 6/17"
        label.font = .systemFont(ofSize: 18, weight: .bold)
        return label
    }()
    
    let rideToTime: UILabel = {
        let label = UILabel()
        label.text = "4:18a"
        label.font = .systemFont(ofSize: 14, weight: .bold)
        return label
    }()
    
    let rideFromTime: UILabel = {
        let label = UILabel()
        label.text = "4:26p"
        label.font = .systemFont(ofSize: 14, weight: .regular)
        return label
    }()
    
    private lazy var tripHeaderStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [rideDate, rideToTime, rideFromTime])
        stackView.distribution = .fill
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.spacing = 10
        return stackView
    }()
    
    private let estimatedLabel: UILabel = {
        let label = UILabel()
        label.text = "ESTIMATED"
        label.font = .systemFont(ofSize: 14, weight: .light)
        return label
    }()
    
    let estimatedCost: UILabel = {
        let label = UILabel()
        label.text = "$105.25"
        label.font = .systemFont(ofSize: 18, weight: .light)
        label.textColor = .blue
        return label
    }()
    
    private lazy var tripEstPriceHeaderStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [estimatedLabel, estimatedCost])
        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        stackView.alignment = .fill
        return stackView
    }()
    
    //MARK: - INITIALIZERS
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        contentView.addSubview(tripHeaderStackView)
        contentView.addSubview(tripEstPriceHeaderStackView)
        contentView.backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - LAYOUT VIEWS
    override func layoutSubviews() {
        super.layoutSubviews()
        configureAutoLayout()
    }
    
    //MARK: PRIVATE FUNCTIONS
    private func configureAutoLayout() {
        
        tripHeaderStackView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalToSuperview().offset(10)
            make.centerY.equalToSuperview()
        }
        
        tripEstPriceHeaderStackView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.right.equalToSuperview()
        }
    }
    
    //MARK: - PUBLIC FUNCTIONS
    func configureHeaderView(ride: Ride) {
        
        // Sets the ride date for the ride
        self.rideDate.text = Helper.dateTimeChangeFormat(str: ride.startsAt, inDateFormat: "yyyy'-'MM'-'dd'T'HH':'mm':'ssZZZ", outDateFormat: "E M/d")
        
    }
}
