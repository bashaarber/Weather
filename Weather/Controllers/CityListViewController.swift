//
//  CityListViewController.swift
//  Weather
//
//  Created by Arber Basha on 16/09/2019.
//  Copyright © 2019 Arber Basha. All rights reserved.
//

import UIKit

class CityListViewController: UIViewController, UITableViewDataSource , UITableViewDelegate {

    
    @IBOutlet weak var tableView: UITableView!
    
    var cityArray: [City] = [City(ID: 786714, name: "Prishtina", state: "XK"),
                             City(ID: 786712, name: "Prizren", state: "XK"),
                             City(ID: 790674, name: "Gjilan", state: "XK"),
                             City(ID: 787157, name: "Peje", state: "XK"),
                             City(ID: 789225, name: "Mitrovice", state: "XK"),
                             City(ID: 784759, name: "Ferizaj", state: "XK"),]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegatesForTable()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    func setDelegatesForTable(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = UIColor.clear
        tableView.layer.backgroundColor = UIColor.clear.cgColor
        tableView.register(UINib(nibName: "CityCell", bundle: nil), forCellReuseIdentifier: "cityCell")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10.0
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView:UIView = UIView()
        headerView.backgroundColor = UIColor.clear
        return headerView
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView:UIView = UIView()
        footerView.backgroundColor = UIColor.clear
        return footerView
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10.0
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.alpha = 0
        
        UIView.animate(
            withDuration: 0.75,
            delay: 0.05 * Double(indexPath.section),
            animations: {
                cell.alpha = 1
        })
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return cityArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cityCell") as! CityCell
        cell.clipsToBounds = true
        cell.layer.cornerRadius = 10
        cell.selectionStyle = .none
        cell.backgroundColor = UIColor.clear
        cell.lblCity.textColor = UIColor.white

        
        let city = cityArray[indexPath.section]
        
        cell.lblCity.text = city.name

        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let city = cityArray[indexPath.section]
        
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "cityVC") as! CityViewController
        vc.cityName = city.name
        vc.idParameter = city.ID
        self.present(vc, animated: true, completion: nil)
    }
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
