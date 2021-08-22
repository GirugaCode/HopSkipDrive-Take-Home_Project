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
//        ride?.orderedWaypoints.count ?? 0
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: rideDetailsCellId) as! RideDetailViewCell
        return cell
    }
    
}
