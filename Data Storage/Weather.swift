//
//  DayWeather.swift
//  Data Storage
//
//  Created by Pavel Koyushev on 15.01.2021.
//

import Foundation
import RealmSwift

class Weather: Object{
    @objc dynamic var day: String = ""
    @objc dynamic var temp: Double = 0.0
    @objc dynamic var weather: String = ""
}
