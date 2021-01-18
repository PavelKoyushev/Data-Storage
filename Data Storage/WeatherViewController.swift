//
//  WeatherViewController.swift
//  Data Storage
//
//  Created by Pavel Koyushev on 15.01.2021.
//

import UIKit
import RealmSwift

class WeatherViewController: UIViewController {

    @IBOutlet private weak var currentWeather: UILabel!
    @IBOutlet private weak var tableView: UITableView!
    
    private var dataManager = WeatherNetwork.shared
    private var weather: Results<Weather>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getWeather()
        updateWeather()
    }
}

extension WeatherViewController {
    func getWeather() {
        self.weather = dataManager.getDays()
    }
    
    func updateWeather() {
        dataManager.loadAlamofire(completion: {self.tableView.reloadData(); self.setCurrentWeather()})
    }
    
    func setCurrentWeather(){
        if weather.count > 0 {
            currentWeather.text = "\(weather[0].temp) \(weather[0].weather)"
        } else {
            currentWeather.text = "0 nan"
        }
    }
}

extension WeatherViewController: UITableViewDataSource, UITableViewDelegate{
    func numberOfSections(in tableView: UITableView) -> Int {
        return weather.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return weather[section].day
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! WeatherTableViewCell
        
        cell.weatherLabel.text = weather[indexPath.section].weather
        cell.tempLabel.text = "\(weather[indexPath.section].temp)"
        return cell
    }
}

