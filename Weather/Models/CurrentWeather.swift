//
//  CurrentWeather.swift
//  Weather
//
//  Created by Arber Basha on 12/09/2019.
//  Copyright © 2019 Arber Basha. All rights reserved.
//

import Foundation
//
//{
//    "coord": {
//        "lon": 21.28,
//        "lat": 42.7
//    },
//    "weather": [
//    {
//    "id": 802,
//    "main": "Clouds",
//    "description": "scattered clouds",
//    "icon": "03n"
//    }
//    ],
//    "base": "stations",
//    "main": {
//        "temp": 20.01,
//        "pressure": 1027,
//        "humidity": 45,
//        "temp_min": 19.44,
//        "temp_max": 20.56
//    },
//    "visibility": 10000,
//    "wind": {
//        "speed": 2.1,
//        "deg": 310
//    },
//    "clouds": {
//        "all": 40
//    },
//    "dt": 1568311899,
//    "sys": {
//        "type": 1,
//        "id": 95,
//        "message": 0.1548,
//        "country": "XK",
//        "sunrise": 1568261460,
//        "sunset": 1568307119
//    },
//    "timezone": 7200,
//    "id": 786713,
//    "name": "Komuna e Prishtinës",
//    "cod": 200
//}


struct CurrentWeather: Codable{
    
    var weather: [weather]
    var main: main
    var visibility: Int
    var wind: wind
    var clouds: clouds
    var dt: Int
    var name: String
    var cod: Int
    
}

struct weather: Codable{
    var id: Int
    var main: String
    var description: String
    var icon: String
}

struct main: Codable{
    var temp: Decimal
    var humidity: Int
}

struct wind: Codable{
    var speed: Decimal
}

struct clouds: Codable{
    var all: Int
}
