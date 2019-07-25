//
//  TableViewController.swift
//  SpaceX_platform
//
//  Created by Eryk Mól on 22.06.19.
//  Copyright © 2019 Eryk Mól. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {

    var serializedData = [[String: Any]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        guard let url = URL(string: "https://api.spacexdata.com/v3/launchpads") else { return }
        
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
                    self.serializedData = jsonDict
                }
                
            } catch let parsingError {
                print("Error", parsingError)
            }
            
                DispatchQueue.main.async() {
                    self.tableView.reloadData()
                }
        }
        task.resume()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let DetailsController = segue.destination as! DetailsViewController
        if let index = self.tableView.indexPathForSelectedRow?.row {
            DetailsController.platformInfo = serializedData[index]
        }
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return serializedData.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> platformCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! platformCell
        
        if let location = serializedData[indexPath.row]["location"] as? [String: Any] {
            if let platformName = location["name"] as? String, let platformStatus = serializedData[indexPath.row]["status"] as? String {
                cell.nameLabel.text = platformName
                cell.statusLabel.text = platformStatus
            }
        }
        
        return cell
    }
 
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 100
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "platformDetailsSegue", sender: nil)
    }
    
}
