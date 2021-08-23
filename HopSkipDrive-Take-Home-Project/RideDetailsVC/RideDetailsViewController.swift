//
//  RideDetailsViewController.swift
//  HopSkipDrive-Take-Home-Project
//
//  Created by Ryan Nguyen on 8/14/21.
//

import SnapKit
import MapKit
import CoreLocation
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
        configureTableView()
        configureAutoLayout()
        configureNavigationBar()
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
        tableView.register(RideDetailViewHeader.self, forHeaderFooterViewReuseIdentifier: RideDetailViewHeader.identifier)
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
    
    /// Sets up the navigation bar for the view
    private func configureNavigationBar() {
        view.backgroundColor = .white
        self.navigationController?.navigationBar.topItem?.title = " "
        navigationItem.title = "Ride Details"
    }
    
}

extension RideDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ride?.orderedWaypoints.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: rideDetailsCellId) as! RideDetailViewCell
        
        cell.addressLabel.text = ride?.orderedWaypoints[indexPath.row].location.address
        
        // Checks with UI components to set based on waypoint being an anchor
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
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: RideDetailViewHeader.identifier) as? RideDetailViewHeader
        
        header?.rideDate.text = Helper.dateTimeChangeFormat(str: ride?.startsAt ?? "", inDateFormat: "yyyy'-'MM'-'dd'T'HH':'mm':'ssZZZ", outDateFormat: "E M/d")
        
        header?.rideToTime.text = "\(Helper.dateTimeChangeFormat(str: ride?.startsAt ?? "", inDateFormat: "yyyy'-'MM'-'dd'T'HH':'mm':'ssZZZ", outDateFormat: "h:mma")) -"
        
        header?.rideFromTime.text = Helper.dateTimeChangeFormat(str: ride?.endsAt ?? "", inDateFormat: "yyyy'-'MM'-'dd'T'HH':'mm':'ssZZZ", outDateFormat: "h:mma")
        
        
        // Calculates the price estimate for header view
        let priceEst = ride?.estimatedEarningsCents.centsToDollars()
        let totalEstPrice = Helper.numberFormatDollars(dollars: priceEst ?? 0.00)
        header?.estimatedCost.text = totalEstPrice
        
        header?.configureHeaderView(ride: ride!)
        
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 270
    }
    
}
