//
//  ViewController.swift
//  SpaceX_platform
//
//  Created by Eryk Mól on 22.06.19.
//  Copyright © 2019 Eryk Mól. All rights reserved.
//

import UIKit
import MapKit

class DetailsViewController: UIViewController {

    @IBOutlet weak var platformTextView: UITextView!
    @IBOutlet weak var mapButton: UIBarButtonItem!
    
    
    var platformInfo = [String: Any]()
    
    var platformCoords = CLLocationCoordinate2D()
    var locationName = String()
    var locationRegion = String()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let regex = "\\{|\\}\n|\\(|\\)\n|\"|;|,"
        
        
        if let platformLocation = platformInfo["location"] as? [String: Any] {
            if let platformLatitude = platformLocation["latitude"] as? CLLocationDegrees, let platformLongitude = platformLocation["longitude"] as? CLLocationDegrees {
                platformCoords = CLLocationCoordinate2D(latitude: platformLatitude, longitude: platformLongitude)
            }
            if let region = platformLocation["region"] as? String{
                locationRegion = region
            }
            if let name = platformLocation["name"] as? String{
                locationName = name
            }
            
        }
        
        var formattedDetails = platformInfo.map{ "\($0): \($1)" }.sorted(by: >).joined(separator: "\n")
        formattedDetails = formattedDetails.replacingOccurrences(of: regex,  with: "", options: .regularExpression)
        formattedDetails = formattedDetails.replacingOccurrences(of: " =",  with: ":")
        formattedDetails = formattedDetails.replacingOccurrences(of: "_",  with: " ")
        
        platformTextView.text = formattedDetails
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let controller = segue.destination as? MapViewController {
            controller.location = platformCoords
            controller.locationName = locationName
            controller.locationRegion = locationRegion
            
        } else if let controller = segue.destination as? RocketsViewController {
            if let vehiclesLaunched = platformInfo["vehicles_launched"] as? [String] {
                controller.vehiclesList = vehiclesLaunched
            }
        }
    }
}
