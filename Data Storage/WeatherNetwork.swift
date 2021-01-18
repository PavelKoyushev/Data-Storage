//
//  Network.swift
//  Data Storage
//
//  Created by Pavel Koyushev on 15.01.2021.
//

import Foundation
import Alamofire
import RealmSwift

//оставляю пока так, позже будет полноценный класс

class WeatherNetwork {
    
    private let realm = try! Realm()
    
    static let shared = WeatherNetwork()
    
    func getDays() -> Results<Weather> {
        return realm.objects(Weather.self)
    }
    
    func loadAlamofire(completion: @escaping () -> Void){
    let url = "https://api.openweathermap.org/data/2.5/forecast?q=Moscow&APPID=079df97bd8aa3caee6293ad8a5c44f40"
        AF.request(url).responseJSON(completionHandler: { [self] response in
        if let data = response.value as? [String : Any],
            let jsonDict = data["list"] as? [NSDictionary]{
            try! realm.write({ realm.delete(getDays()) })
            
            for day in jsonDict{
                let dayInfo = Weather()
                
                if let date = day["dt_txt"] as? String, let temp = day["main"] as? [String: Double],
                   let weather = day["weather"] as? [[String: Any]] {
                   dayInfo.day = date
                   dayInfo.temp = temp["temp"] ?? 0
                   dayInfo.weather = weather[0]["description"] as? String ?? "no info"
                    
                   try! realm.write({
                    realm.add(dayInfo)
                   })
                }
                
                DispatchQueue.main.async {
                    completion()
                }
            }
        }
        })
    }

}
