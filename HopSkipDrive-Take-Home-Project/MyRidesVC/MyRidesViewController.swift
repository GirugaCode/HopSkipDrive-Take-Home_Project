//
//  MyRidesViewController.swift
//  HopSkipDrive-Take-Home-Project
//
//  Created by Ryan Nguyen on 8/13/21.
//

import SnapKit
import UIKit

class MyRidesViewController: UIViewController {
    
    //MARK: - PROPERTIES
    var currentRides: [Ride] = [] {
        didSet {
            groupCurrentRides()
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    var groupedByDateRides = [[Ride]]()
    private var tableView: UITableView!
    private let cellRowHeight: CGFloat = 140
    private let myRidesCellId = "MyRidesCellId"

    //MARK: - VIEW CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchRidesData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureNavigationBar()
        configureTableView()
        configureAutoLayout()
    }
    
    //MARK: - PRIVATE FUNCTIONS
    /// Sets up UI for navigation bar
    private func configureNavigationBar() {
        navigationItem.title = "My Rides"
        
        if #available(iOS 13.0, *) {
            let appearance = UINavigationBarAppearance()
            appearance.backgroundColor = .purple
            appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
            appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]

            navigationController?.navigationBar.tintColor = .white
            navigationController?.navigationBar.standardAppearance = appearance
            navigationController?.navigationBar.compactAppearance = appearance
            navigationController?.navigationBar.scrollEdgeAppearance = appearance
        } else {
            navigationController?.navigationBar.tintColor = .white
            navigationController?.navigationBar.barTintColor = .purple
            navigationController?.navigationBar.isTranslucent = false
        }
    }
    
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
        tableView.register(MyRidesCell.self, forCellReuseIdentifier: myRidesCellId)
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
    
    /// Calls the NetworkService to fetch data from API
    private func fetchRidesData() {
        NetworkService.request(endpoint: HopSkipDriveEndpoint.getRideResults) { (result: Result<HopSkipDriveResponse, Error>) in
            switch result {
            case .success(let response):
                self.currentRides = response.rides
            case .failure(let error):
                print("Error:", error)
            }
        }
    }
    
    /// Groups the rides given by date
    private func groupCurrentRides(){
        let datedRides = Dictionary(grouping: currentRides) { (element) -> String in
            let rideByDate = Helper.dateTimeChangeFormat(str: element.startsAt, inDateFormat: "yyyy'-'MM'-'dd'T'HH':'mm':'ssZZZ", outDateFormat: "E M/d")
            return rideByDate
        }
        
        let sortedKeys = datedRides.keys.sorted(by: {$0 > $1})
        sortedKeys.forEach { (key) in
            let values = datedRides[key]
            groupedByDateRides.append(values ?? [])
        }
    
    }
}

extension MyRidesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groupedByDateRides[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyRidesCellId", for: indexPath) as! MyRidesCell
        cell.configureCell(ride: groupedByDateRides[indexPath.section][indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let controller = RideDetailsViewController()
        controller.ride = groupedByDateRides[indexPath.section][indexPath.row]
        
        navigationController?.pushViewController(controller, animated: true)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: MyRidesHeaderView.identifier) as? MyRidesHeaderView
        for headerSection in groupedByDateRides[section] {
            header?.configureHeaderView(ride: headerSection)
        }
        
        let earliestStartTimeMap = groupedByDateRides[section].map {$0.startsAt}
        if let earliestStartTime = earliestStartTimeMap.sorted().first {
            header?.rideToTime.text = "\(Helper.dateTimeChangeFormat(str: earliestStartTime, inDateFormat: "yyyy'-'MM'-'dd'T'HH':'mm':'ssZZZ", outDateFormat: "h:mma")) -"
        }


        let latestStartTimeMap = groupedByDateRides[section].map {$0.endsAt}
        if let latestStartTime = latestStartTimeMap.sorted().last {
            header?.rideFromTime.text = Helper.dateTimeChangeFormat(str: latestStartTime, inDateFormat: "yyyy'-'MM'-'dd'T'HH':'mm':'ssZZZ", outDateFormat: "h:mma")
        }
        

        // Calculates the total estimated cost for each section
        let centsPerSection = groupedByDateRides[section].map() {$0.estimatedEarningsCents}
        let sumCentsPerSection = centsPerSection.reduce(0, +)
        let priceEst = sumCentsPerSection.centsToDollars()
        let totalEstimatedCost = Helper.numberFormatDollars(dollars: priceEst)
        header?.estimatedCost.text = "\(totalEstimatedCost ?? "")"
        
        return header
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return groupedByDateRides.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
}
