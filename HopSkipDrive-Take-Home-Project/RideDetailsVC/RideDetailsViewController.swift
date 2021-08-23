//
//  RideDetailsViewController.swift
//  HopSkipDrive-Take-Home-Project
//
//  Created by Ryan Nguyen on 8/14/21.
//

import SnapKit
import UIKit

class RideDetailsViewController: UIViewController {
    //MARK: - PROPERTIES
    var ride: Ride?
    
    //MARK: - UI COMPONENTS
    private var tableView: UITableView!
    private let cellRowHeight: CGFloat = 100
    private let rideDetailsCellId = "RideDetailsCellId"
    
    //MARK: - VIEW CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .darkGray
        navigationItem.title = "Ride Details"
        configureTableView()
        configureAutoLayout()
    }
    
    //MARK: - PRIVATE FUNCTION
    /// Configures the table view of Playback View Controller
    private func configureTableView() {
        tableView = UITableView(frame: .zero, style: .grouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = cellRowHeight
        tableView.isScrollEnabled = true
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorStyle = .none
        tableView.backgroundColor = .white
        tableView.register(RideDetailViewCell.self, forCellReuseIdentifier: rideDetailsCellId)
        tableView.register(MyRidesHeaderView.self, forHeaderFooterViewReuseIdentifier: MyRidesHeaderView.identifier)
    }
    
    /// Configures the views/autolayout of MyRidesViewController
    private func configureAutoLayout() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(view.snp.top)
            make.left.equalTo(view.snp.left)
            make.right.equalTo(view.snp.right)
            make.bottom.equalTo(view.snp.bottom)
        }
    }
    
}

extension RideDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ride?.orderedWaypoints.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: rideDetailsCellId) as! RideDetailViewCell
        if let ride = ride {
            cell.configureCell(ride: ride)
        }
        
        cell.addressLabel.text = ride?.orderedWaypoints[indexPath.row].location.address
        
        let anchor = ride?.orderedWaypoints[indexPath.row].anchor
        if anchor ?? true {
            cell.pickUpDropOffLabel.text = "Pickup"
            cell.symbol.image = #imageLiteral(resourceName: "diamond")
        } else {
            cell.pickUpDropOffLabel.text = "Drop-off"
            cell.symbol.image = #imageLiteral(resourceName: "circle")
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: MyRidesHeaderView.identifier) as? MyRidesHeaderView
        
        header?.rideDate.text = Helper.dateTimeChangeFormat(str: ride?.startsAt ?? "", inDateFormat: "yyyy'-'MM'-'dd'T'HH':'mm':'ssZZZ", outDateFormat: "E M/d")
        
        header?.rideFromTime.text = Helper.dateTimeChangeFormat(str: ride?.startsAt ?? "", inDateFormat: "yyyy'-'MM'-'dd'T'HH':'mm':'ssZZZ", outDateFormat: "h:mma")
        
        header?.rideToTime.text = Helper.dateTimeChangeFormat(str: ride?.endsAt ?? "", inDateFormat: "yyyy'-'MM'-'dd'T'HH':'mm':'ssZZZ", outDateFormat: "h:mma")
        
        
        let priceEst = ride?.estimatedEarningsCents.centsToDollars()
        let totalEstPrice = Helper.numberFormatDollars(dollars: priceEst ?? 0.00)
        header?.estimatedCost.text = totalEstPrice
        
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
}
