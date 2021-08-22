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
    var currentRides: [Ride] = []
    private var tableView: UITableView!
    private let cellRowHeight: CGFloat = 180
    private let myRidesCellId = "MyRidesCellId"

    //MARK: - VIEW CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
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
        tableView.register(MyRidesHeaderView.self, forHeaderFooterViewReuseIdentifier: "Header")
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
}

extension MyRidesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentRides.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyRidesCellId", for: indexPath) as! MyRidesCell
        cell.configureCell(ride: currentRides[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = RideDetailsViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "Header") as? MyRidesHeaderView
        header?.configureHeaderView(ride: currentRides[section])
        print("Section:", section)
        return header
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
}
