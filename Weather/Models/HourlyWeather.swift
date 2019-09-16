//
//  HourlyWeather.swift
//  Weather
//
//  Created by Arber Basha on 16/09/2019.
//  Copyright © 2019 Arber Basha. All rights reserved.
//

import Foundation


struct HourlyWeather: Codable{
    
    var list: [list]
    
}

struct list: Codable{
    var dt: Int
    var main: main
    var weather: [weather]
}


