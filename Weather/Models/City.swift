//
//  City.swift
//  Weather
//
//  Created by Arber Basha on 16/09/2019.
//  Copyright © 2019 Arber Basha. All rights reserved.
//

import UIKit

class City: NSObject {
    
    var ID: Int = 0
    var name: String = ""
    var state: String = ""
    
    init(ID: Int, name: String, state: String) {
        self.ID = ID
        self.name = name
        self.state = state
    }
    


}


