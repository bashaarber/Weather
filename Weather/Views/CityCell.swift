//
//  CityCell.swift
//  Weather
//
//  Created by Arber Basha on 16/09/2019.
//  Copyright © 2019 Arber Basha. All rights reserved.
//

import UIKit

class CityCell: UITableViewCell {

    
    @IBOutlet weak var lblCity: UILabel!
    @IBOutlet weak var lblState: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
