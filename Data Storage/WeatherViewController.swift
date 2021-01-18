//
//  WeatherViewController.swift
//  Data Storage
//
//  Created by Pavel Koyushev on 15.01.2021.
//

import UIKit

class WeatherViewController: UIViewController {

    @IBOutlet private weak var currentWeather: UILabel!
    @IBOutlet private weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setCurrentWeather()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadAlamofire(completion: {self.tableView.reloadData(); self.setCurrentWeather()})
    }
}

extension WeatherViewController {
    func setCurrentWeather(){
        if days.count > 0 {
            currentWeather.text = "\(days[0].temp) \(days[0].weather)"
        } else {
            currentWeather.text = "0 nan"
        }
    }
}

extension WeatherViewController: UITableViewDataSource, UITableViewDelegate{
    func numberOfSections(in tableView: UITableView) -> Int {
        return days.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return days[section].day
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! WeatherTableViewCell
        
        cell.weatherLabel.text = days[indexPath.section].weather
        cell.tempLabel.text = "\(days[indexPath.section].temp)"
        return cell
    }
}

