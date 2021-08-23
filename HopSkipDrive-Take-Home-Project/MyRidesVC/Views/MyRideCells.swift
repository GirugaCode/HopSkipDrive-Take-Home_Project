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
        view.layer.shadowRadius = 5
        view.layer.cornerRadius = 10
        return view
    }()
    
    private lazy var tripCardHeaderStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [startTime, endTime])
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
        label.font = .systemFont(ofSize: 10, weight: .regular)
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
    
    let addressList: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 15, weight: .thin)
        label.lineBreakMode = .byWordWrapping
        label.sizeToFit()
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
        backView.addSubview(numberOfRiders)
        backView.addSubview(priceEst)
        backView.addSubview(addressList)
        
        tripCardHeaderStackView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.left.equalToSuperview().offset(15)
        }
        
        numberOfRiders.snp.makeConstraints { make in
            make.top.equalTo(tripCardHeaderStackView.snp.top)
            make.left.equalTo(tripCardHeaderStackView.snp.right)
        }
        
        priceEst.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-15)
        }
        
        addressList.snp.makeConstraints { make in
            make.top.equalTo(tripCardHeaderStackView.snp.bottom)
            make.left.equalToSuperview().offset(15)
            make.right.equalToSuperview().offset(-15)
            make.bottom.equalToSuperview()
        }
        
    }
    //MARK: - PUBLIC FUNCTIONS
    
    /// Configures the data for each cell
    func configureCell(ride: Ride) {
    
        self.startTime.text = "\(Helper.dateTimeChangeFormat(str: ride.startsAt, inDateFormat: "yyyy'-'MM'-'dd'T'HH':'mm':'ssZZZ", outDateFormat: "h:mma")) - "
        self.endTime.text = Helper.dateTimeChangeFormat(str: ride.endsAt, inDateFormat: "yyyy'-'MM'-'dd'T'HH':'mm':'ssZZZ", outDateFormat: "h:mma")
        
        /// Calculates the maximum amount of riders for each trip
        guard let maxRiders = (ride.orderedWaypoints.max { $0.passengers.count < $1.passengers.count
        })?.passengers.count else { return }
                
        self.numberOfRiders.text = "(\(maxRiders) riders)"
        
        // Looping through all the passengers and assigning booster seats
        ride.orderedWaypoints.forEach {$0.passengers.forEach { boosterSeat in
            if boosterSeat.boosterSeat {
                self.numberOfRiders.text = "(\(maxRiders) riders)" + "• (1 booster)"
                }
            }
        }
        
        // Conditional text if there is only one rider
        if maxRiders <= 1 {
            self.numberOfRiders.text = "(\(maxRiders) rider)"
        }
        
        
        let priceEst = ride.estimatedEarningsCents.centsToDollars()

        let totalRiders = Helper.numberFormatDollars(dollars: priceEst)
        self.priceEst.text = "est. \(totalRiders ?? "")"
        
        //TODO: Add numbered order to each address the their cells
        let addy = ride.orderedWaypoints.map({$0.location.address})
        let multiLineAddress = addy.joined(separator: "\n")
        self.addressList.text = multiLineAddress
        
    }

}

