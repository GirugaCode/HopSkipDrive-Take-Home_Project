//
//  MKMapView+Extension.swift
//  HopSkipDrive-Take-Home-Project
//
//  Created by Ryan Nguyen on 8/22/21.
//

import UIKit
import MapKit

extension MKMapView {

    /// Displays all annotations in the map zoomed in
    func fitAll() {
        var zoomRect = MKMapRect.null;
        for annotation in annotations {
            let annotationPoint = MKMapPoint(annotation.coordinate)
            let pointRect = MKMapRect(x: annotationPoint.x, y: annotationPoint.y, width: 0.1, height: 0.1);
            zoomRect = zoomRect.union(pointRect);
        }
        setVisibleMapRect(zoomRect, edgePadding: UIEdgeInsets(top: 350, left: 350, bottom: 350, right: 350), animated: true)
    }

}
