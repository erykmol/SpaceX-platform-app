//
//  platformCell.swift
//  SpaceX_platform
//
//  Created by Eryk Mól on 22.06.19.
//  Copyright © 2019 Eryk Mól. All rights reserved.
//

import UIKit

class platformCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var statusLabel: UILabel!
    
    @IBOutlet weak var thumbnailImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
