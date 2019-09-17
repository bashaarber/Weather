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

class CityViewController: UIViewController, UICollectionViewDelegate , UICollectionViewDataSource {

    

    var cityName: String = ""
    var idParameter: Int = 0
    var weatherList: HourlyWeather!
    var blurEffectView: UIView!
    
    @IBOutlet weak var lblCity: UILabel!
    @IBOutlet weak var lblCurrentTemp: UILabel!
    @IBOutlet weak var imgWeatherIcon: UIImageView!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var lblHumidity: UILabel!
    @IBOutlet weak var lblWind: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        createCustomBlur()
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        lblCity.text = cityName
        createScreenEdgeSwipe()
        fetchJSON(parameter: idParameter)
        fetchJSONDaily(parameter: idParameter)
    }
    

    @IBAction func btnBackTap(_ sender: Any) {
        self.dismiss(animated: false) {
            
        }
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
                    self.lblCurrentTemp.text = CW.main.temp.formattedString + "°C"
                    self.imgWeatherIcon.sd_setImage(with: URL(string: "https://openweathermap.org/img/wn/\(CW.weather[0].icon)@2x.png"))
                    self.lblDescription.text = CW.weather[0].description
                    self.lblHumidity.text = String(CW.main.humidity) + " %"
                    self.lblWind.text = CW.wind.speed.formattedString + " mph"
                }catch let jsonErr{
                    print("failed",jsonErr)
                }
            }
            
            }.resume()
        
    }
    
    func fetchJSONDaily(parameter: Int){
        let urlString = "https://api.openweathermap.org/data/2.5/forecast?id=\(parameter)&APPID=43dc624a30541bf02f0055aca49e8224&units=metric"
        
        let url = URL(string: urlString)!
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            DispatchQueue.main.async {
                if let error = error{
                    print("something failed",error)
                }
                
                guard let data = data else {return}
                
                do{
                    let decoder = JSONDecoder()
                    self.weatherList = try decoder.decode(HourlyWeather.self, from: data)
                    self.collectionView.reloadData()
                    SVProgressHUD.dismiss()
                    self.blurEffectView.removeFromSuperview()
                }catch let jsonErr{
                    print("failed",jsonErr)
                }
            }
            
            }.resume()
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        cell.alpha = 0
        
        UIView.animate(
            withDuration: 0.75,
            delay: 0.05 * Double(indexPath.row),
            animations: {
                cell.alpha = 1
        })
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WeatherCollectionViewCell", for: indexPath) as! WeatherCollectionViewCell
        cell.backgroundColor = UIColor.clear
        if weatherList != nil{
            cell.lblTemp.text = weatherList.list[indexPath.row].main.temp.formattedString + "°C"
            cell.imgWeather.sd_setImage(with: URL(string: "https://openweathermap.org/img/wn/\(weatherList.list[indexPath.row].weather[0].icon)@2x.png"))
            let date = NSDate(timeIntervalSince1970: TimeInterval(weatherList.list[indexPath.row].dt))
            let calendar = Calendar.current
            let hour = calendar.component(.hour, from: date as Date)
            let hourStr = String(hour)
            cell.lblTime.text = hourStr + "h"
            
        }


        
        return cell
    }
    
    func createCustomBlur(){
        let blurEffect = UIBlurEffect(style: .regular) // .extraLight or .dark
        blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.frame
        view.addSubview(blurEffectView)
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
