//
//  RocketsViewController.swift
//  SpaceX_platform
//
//  Created by Eryk Mól on 27.06.19.
//  Copyright © 2019 Eryk Mól. All rights reserved.
//

import UIKit

class RocketsViewController: UIViewController {

    
    @IBOutlet weak var RocketsTextView: UITextView!
    @IBOutlet weak var closeButton: UIButton!
    
    var vehiclesList = [String]()
    
    var serializedData = "Rockets: "
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let regex = "\\{|\\}\n|\\(\n|\\)\n|\"|;|,|\\}|\\{"
        
        guard let url = URL(string: "https://api.spacexdata.com/v3/rockets") else { return }
        
        for vehicle in vehiclesList {
            serializedData += vehicle + "\n"
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            guard error == nil else {
                print ("error: \(error!)")
                return
            }
            
            guard let content = data else {
                print("No data")
                return
            }
            
            do{
                
                let jsonResponse = try JSONSerialization.jsonObject(with:
                    content, options: [])
                
                if let jsonDict = jsonResponse as? [[String: Any]] {
                    for rocket in jsonDict {
                        if let rocketName = rocket["rocket_name"] as? String {
                            if self.vehiclesList.contains(rocketName) {
                                self.serializedData += rocket.map{ "\($0): \($1)" }.sorted(by: >).joined(separator: "\n")
                            }
                        }
                    }
                }
                
                DispatchQueue.main.async {
                    var formattedDetails = self.serializedData.replacingOccurrences(of: regex,  with: "", options: .regularExpression)
                    formattedDetails = formattedDetails.replacingOccurrences(of: " =",  with: ":")
                    formattedDetails = formattedDetails.replacingOccurrences(of: "_",  with: " ")
                    
                    self.RocketsTextView.text = formattedDetails
                }
                
            } catch let parsingError {
                print("Error", parsingError)
            }
            
        }
        task.resume()
    }
    
    @IBAction func onCloseButtonClick(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

}
