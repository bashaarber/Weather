//
//  CityViewController.swift
//  Weather
//
//  Created by Arber Basha on 12/09/2019.
//  Copyright © 2019 Arber Basha. All rights reserved.
//

import UIKit
import SDWebImage
import SVProgressHUD

class CityViewController: UIViewController {

    var cityName: String = ""
    var idParameter: Int = 0
    
    @IBOutlet weak var lblCity: UILabel!
    @IBOutlet weak var lblCurrentTemp: UILabel!
    @IBOutlet weak var imgWeatherIcon: UIImageView!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var lblHumidity: UILabel!
    @IBOutlet weak var lblWind: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lblCity.text = cityName
        createScreenEdgeSwipe()
        fetchJSON(parameter: idParameter)
    }
    
    func fetchJSON(parameter: Int){
        SVProgressHUD.show()
        let urlString = "https://api.openweathermap.org/data/2.5/weather?id=\(parameter)&APPID=43dc624a30541bf02f0055aca49e8224&units=metric"
        
        let url = URL(string: urlString)!
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            DispatchQueue.main.async {
                if let error = error{
                    print("something failed",error)
                }
                
                guard let data = data else {return}
                
                do{
                    let decoder = JSONDecoder()
                    let CW = try decoder.decode(CurrentWeather.self, from: data)
                    self.lblCurrentTemp.text = CW.main.temp.formattedString
                    self.imgWeatherIcon.sd_setImage(with: URL(string: "https://openweathermap.org/img/wn/\(CW.weather[0].icon)@2x.png"))
                    self.lblDescription.text = CW.weather[0].description
                    self.lblHumidity.text = String(CW.main.humidity) + " %"
                    self.lblWind.text = CW.wind.speed.formattedString + " mph"
                    SVProgressHUD.dismiss()
                }catch let jsonErr{
                    print("failed",jsonErr)
                }
            }
            
            }.resume()
        
    }
    
    
    
    func createScreenEdgeSwipe(){
        let edgePan = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(screenEdgeSwiped))
        edgePan.edges = .left
        
        view.addGestureRecognizer(edgePan)
    }
    
    @objc func screenEdgeSwiped(_ recognizer: UIScreenEdgePanGestureRecognizer) {
        if recognizer.state == .recognized {
            self.dismiss(animated: false) {
                
            }
        }
    }
}
