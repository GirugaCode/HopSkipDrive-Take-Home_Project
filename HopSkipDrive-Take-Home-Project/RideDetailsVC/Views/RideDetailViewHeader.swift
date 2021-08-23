//
//  RideDetailViewHeader.swift
//  HopSkipDrive-Take-Home-Project
//
//  Created by Ryan Nguyen on 8/22/21.
//

import SnapKit
import MapKit
import CoreLocation
import UIKit

class RideDetailViewHeader: UITableViewHeaderFooterView, MKMapViewDelegate {
    
    //MARK: - PROPERTIES
    
    /// Static string identifier for header view
    static let identifier = "RideDetailViewHeader"
    
    /// Map View initialization
    let mapView = MKMapView()
    
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
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        label.textColor = .systemBlue
        return label
    }()
    
    private lazy var tripEstPriceHeaderStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [estimatedLabel, estimatedCost])
        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        stackView.alignment = .fill
        return stackView
    }()
    
    let tripSeriesLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .light)
        label.text = "This trip is part of a series."
        return label
    }()
    
    //MARK: - INITIALIZERS
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        contentView.addSubview(tripHeaderStackView)
        contentView.addSubview(tripEstPriceHeaderStackView)
        contentView.addSubview(mapView)
        contentView.addSubview(tripSeriesLabel)
        contentView.backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - LAYOUT VIEWS
    override func layoutSubviews() {
        super.layoutSubviews()
        configureAutoLayout()
        configureMapView()
    }
    
    //MARK: PRIVATE FUNCTIONS
    private func configureAutoLayout() {
        
        tripHeaderStackView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalToSuperview().offset(10)
            make.centerY.equalTo(tripEstPriceHeaderStackView.snp.centerY)
        }
        
        tripEstPriceHeaderStackView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.right.equalToSuperview()
        }
        
        mapView.snp.makeConstraints { make in
            make.top.equalTo(tripEstPriceHeaderStackView.snp.bottom)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalToSuperview().offset(-15)
        }
        
        tripSeriesLabel.snp.makeConstraints { make in
            make.top.equalTo(mapView.snp.bottom)
            make.left.equalToSuperview().offset(10)
            make.height.equalTo(25)
        }
    }
    
    /// Sets up the map view
    private func configureMapView() {
        mapView.mapType = .standard
        mapView.isZoomEnabled = true
        mapView.isScrollEnabled = true
    }
    
    //MARK: - PUBLIC FUNCTIONS
    func configureHeaderView(ride: Ride) {
        
        // Adds all the annotations of locations to the map
        ride.orderedWaypoints.forEach({ waypoint in
            let annotation = MKPointAnnotation()
            annotation.coordinate = CLLocationCoordinate2D(latitude: waypoint.location.lat, longitude: waypoint.location.lng)
            mapView.addAnnotation(annotation)
        })
        
        // Zooms the map to the annotations of interest
        mapView.fitAll()
        
        // Logic to show if the ride is part of a series
        if ride.inSeries {
            tripSeriesLabel.isHidden = false
        } else {
            tripSeriesLabel.isHidden = true
        }
        
    }
    
    /// Provides the default annotation view
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard annotation is MKPointAnnotation else { return nil }

        let identifier = "Annotation"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)

        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView!.canShowCallout = true
        } else {
            annotationView!.annotation = annotation
        }

        return annotationView
    }

}


