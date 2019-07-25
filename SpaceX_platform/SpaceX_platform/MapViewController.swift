//
//  MapViewController.swift
//  SpaceX_platform
//
//  Created by Eryk Mól on 27.06.19.
//  Copyright © 2019 Eryk Mól. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    
    var location = CLLocationCoordinate2D()
    
    var locationName = String()
    var locationRegion = String()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let span = MKCoordinateSpan(latitudeDelta: 0.035, longitudeDelta: 0.035)
        let region = MKCoordinateRegion(center: location, span: span)
        mapView.setRegion(region, animated: true)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = location
        annotation.title = locationName
        annotation.subtitle = locationRegion
        mapView.addAnnotation(annotation)
        
    }

}
