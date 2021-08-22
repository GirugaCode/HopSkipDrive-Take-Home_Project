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
    
    private lazy var tripCardHeaderStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [startTime, endTime, numberOfRiders])
        stackView.distribution = .fillEqually
        stackView.axis = .horizontal
        stackView.alignment = .fill
        return stackView
    }()
    
    private let startTime: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .bold)
        label.numberOfLines = 0
        label.text = "4:18a"
        return label
    }()
    
    private let endTime: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .regular)
        label.text = "- 5:57a"
        return label
    }()
    
    let numberOfRiders: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .regular)
        label.text = "(2 riders)"
        return label
    }()
    
    private let priceEst: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .semibold)
        label.text = "est. $60.71"
        label.textColor = .systemBlue
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
        
        backView.addSubview(tripCardHeaderStackView)
        backView.addSubview(priceEst)
        
        tripCardHeaderStackView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.left.equalToSuperview().offset(15)
        }
        
        priceEst.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-15)
        }
        
    }
    
    func configureCell(ride: Ride) {
    
        self.startTime.text = Helper.dateTimeChangeFormat(str: ride.startsAt, inDateFormat: "yyyy'-'MM'-'dd'T'HH':'mm':'ssZZZ", outDateFormat: "hh:mm")
        self.endTime.text = Helper.dateTimeChangeFormat(str: ride.endsAt, inDateFormat: "yyyy'-'MM'-'dd'T'HH':'mm':'ssZZZ", outDateFormat: "hh:mm")
//        self.numberOfRiders.text = ride.orderedWaypoints[1]
//
//        for orderedWaypoint in ride.orderedWaypoints {
//            let riderCount = orderedWaypoint.passengers.count
//        }
        
        /// Calculates the maximum amount of drivers for each trip
        guard let maxRiders = (ride.orderedWaypoints.max { $0.passengers.count < $1.passengers.count
        })?.passengers.count else { return }
        
        self.numberOfRiders.text = "(\(maxRiders) riders)"
        
        
        let priceEst = ride.estimatedEarningsCents.centsToDollars()
        let numberFormatter = NumberFormatter()
        numberFormatter.groupingSeparator = ","
        numberFormatter.groupingSize = 3
        numberFormatter.usesGroupingSeparator = true
        numberFormatter.decimalSeparator = "."
        numberFormatter.numberStyle = .currency
        numberFormatter.maximumFractionDigits = 2
        
        let number = NSNumber(value: priceEst)
        
        guard let formattedValue = numberFormatter.string(from: number) else { return }
        self.priceEst.text = "est. \(formattedValue)"
        
    }

}

